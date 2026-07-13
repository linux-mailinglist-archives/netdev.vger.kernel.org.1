Return-Path: <netdev+bounces-307097-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 152WID6pVGoMpAMAu9opvQ
	(envelope-from <netdev+bounces-307097-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:00:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC2A7490AD
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:00:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=bhZpWy9p;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307097-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307097-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4259F302E0DE
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154A23D6479;
	Mon, 13 Jul 2026 08:57:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A897F3D646E
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 08:57:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933075; cv=pass; b=fqX+/rhAQYN6nwAgUktsP9ks3aTAtW+fR6kfEfK2lVSgefYF1A4HvsS7uGI68Uvpc4Z2CNuC2T9dD2Ket4OHCa1jX7Q8iCeRCicQcp6MdmvTqFmwn0cVGxHyNCxpW7SoW17ixCJmanHcd6fgwE7Y7VEuJ8lNLle+KxiT3msdJcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933075; c=relaxed/simple;
	bh=zGXlgemVtM/fd1QacjWZsPwmu1tJ8IeGxyTqkvyGisI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5brGbcAsAVLur5naLVzhOtgtpHcYgPV0vqNaKYWiddh6vwgWfIcGquGbXP36TpxPp8x7cgrZc6lHCOuNrXpK2NOuV7gwEVjbulJeOctLYRapzA4RwTmDbdf+B5vqDLHsZsr65POUKE5s298pHuc5wp9HzKpQrflmnLjXOOg/X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bhZpWy9p; arc=pass smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47640541585so1322847f8f.1
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 01:57:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783933071; cv=none;
        d=google.com; s=arc-20260327;
        b=EN96Hi3i2Zy5/HwbIc/ApWF+BJsIbW3/m+wl/AW3YL7lTdU7VFDqkzmvMi59k1mAa2
         YLQ9Xr/9jtB5wQs+WNodkkhE03nDtD3N4ZA9qOz8E0UTi/4pG4XDCZjmulLNwottG/mJ
         /ZrixKMqBrEGtdfzbJGDETf1P7k27COj3fc20/BikVyn2dA35ZYs/MtuO0Ahve0w0lYN
         i2rA10T/rKktlMbn7BoqtL05jXOv2BRIPElF93ojNiA4dVUcU9oCp4sYXEdeKobIex4P
         6tFGZ89QyCY4MU/PqqaSMS/T364cTiOdIzVXC0NIj0/7DrVB1I/CZooywaRwdWe/XoW1
         exEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        fh=DLUKQgcLzYnQjlaHTK3G4xDsHMtwPcwl1AOFxF4xtjg=;
        b=lDWqdMGlCSSBO6GHt5+KfHDUm5sfzhpu+YL0ND+ds2FWfK4SS6SoPp8thD2mFNcLyD
         KhF0uEFPYQok+bIkpRZkjcpQmG9pdj+pSvAVeeYfnORyKN7OXs90N8/f4UFdmdUldMeD
         /Nm/lOB3/rNVw+oZGzaufQOvz0piNetNiqqMqhLj2rTXnckd6NLusACrXMzGTHppMu20
         jbWHsKi7qdxnmU2NpKO4XgUIa7hqhw2wuiaY+QgY7DzsEz0M5P2Nn9q9DgZR0iE09xnd
         eUVxMwrfNtYhCB89/YDfBwH/M6WZ4fZU8yleWMRrPvEvH9gIvJJyLg+oe8Rg7tCvWVVP
         F5aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783933071; x=1784537871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=bhZpWy9p92MsHXolXEEEzyqO6a8taUshJqNTLDakidqvhciCwPleXpZnFFjlWiYgu2
         PD4KtR4wi8mFviwOMoQsSLwoiUrgbFxzrfMzPSO3Sybm9n1+9I9aGIKm/8G9v52bT/Dy
         /ECgJDqbQXnj9gc2kOfy3eG3Oyas3PdEqt32qqoJCGj+tlRe2CTAPATVLVaT2ZBSLmFE
         6NLrPC6nlM9BaqCBTXA2N+qswyb64G3vtCx9kHyfA9GDzZl//f+Oby1N7yx4QVQbPtoh
         MUkxAek+4XmOD/fokqGCzy3ZmMRVg9nKjm32kMvJgFt/LiXZSc+ZvzDDjsD9s3OVP1/l
         B5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783933071; x=1784537871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Niw6ma3uSQo4Oag5BSyj5O/UfANxhnZNo3KLkxIFV/I=;
        b=fLF1tzcgg2h+Olc48K1FsYbmJ40ZvIafIpdsuH4plKHK4z6VgTiSXgyfdlAkMvLpZi
         Rg3kypdwFvlWsvjGaVL7vzAK4naV8rXjZ/4vGI5CHqgaDAofe1SlZhfSeHjy4DtwPiw8
         33RSXO1AIY0Zux6284ZCQjrrBFqogmgzTrZN/HUktFsrMB0m/y4JGDxM2LEpfeR79V2B
         ZZjpqB9Yz9skDKKMlrnVpP/PXaQiCrmlSP8lAcW0qHFheDmPblq0XuaEmuOu3EKU5+D5
         4R2FIwaeqBcCDJgcZIhxAWQjelHDZ7NTAudk0NrtrqqmpP3K3jmcWtfW0VMgOIaAM1Ma
         KxPg==
X-Forwarded-Encrypted: i=1; AHgh+Rro12kLnf1pQp+RNCK4fdNd6xDb1QOQnv0DZqs6CALFZDUWlWE7AEazF5etxFbTAPURVkiNQj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ7y/lIg1L9q7OV2zoJehJivuMDA3nRxX68Lp/NXfpr+Sm0HqP
	j1ov0pPjqEQmIou5CDJecXAd3cVMehMPqXXqAvixVkox430OOl+sZaqMth1FYrvBDH9YKyXkU6T
	w0HxbYR7aHT9znh3jAL4f/bccQn4OD5mOhiJxqP1L
X-Gm-Gg: AfdE7cmLUwMcEPGoLFN19g7O9dtZolRd3J8PZY3HkEMFufhgn8pVJu3uzcBz2NIgCyn
	jHQEs96CbVrjI4C6pKHbYE3ZEcd7vuzAA+SMkhTONO5x48u4OpFgTwsZlUfXBts3Z3VdFBBMpwE
	IXBSmTNsdJgaYBFU3M7/zvAZZ05XqCm4o08wxPTR+5+nIuwgIm6YoM2JGddhmxEMY7EoUB9ewfs
	C9lLfyqcTO9jDjkLYXevj9uyZMPSsejKEYPm4cdn4xmcecOvBvo7twgivPMh61c00ioz1fky+ut
	xGevsDArOA6Gm5i0WYlAWxm0lkk/XTLdXrX/xsDdlFkdjv9iyoa7C9zyVBPrLf4F16m8JA==
X-Received: by 2002:a5d:5850:0:b0:472:55a:ef9b with SMTP id
 ffacd0b85a97d-47f2dcac418mr8602513f8f.8.1783933070140; Mon, 13 Jul 2026
 01:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-10-2495cfa82d47@linux.dev> <alSe6PsvdrSYP_Z0@google.com>
 <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
In-Reply-To: <d7c1607f-ea74-442a-9700-7fc4f0c64b76@linux.dev>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 13 Jul 2026 10:57:37 +0200
X-Gm-Features: AUfX_mw1uUYgV4eMXkVflbUYoDKpPh-OOQHMx0yAVcG6yUMQsdEhmzk4SLg_fQ0
Message-ID: <CAH5fLggszOnUm7Rykt41V91de8h9YVaZt49wr52i3t5-QV84Xg@mail.gmail.com>
Subject: Re: [PATCH v8 10/10] rust: module: update MAINTAINERS to cover module.rs
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
	Igor Korotin <igor.korotin@linux.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org, 
	linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:alvin.sun@linux.dev,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:dakr@kernel.org,m:mcgrof@kernel.org,m:petr.pavlu@suse.com,m:da.gomez@kernel.org,m:samitolvanen@google.com,m:atomlin@atomlin.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:daniel.almeida@collabora.com,m:arnd@arndb.de,m:brendan.higgins@linux.dev,m:david@davidgow.net,m:raemoar63@gmail.com,m:leitao@debian.org,m:axboe@kernel.dk,m:david.m.ertman@intel.com,m:leon@kernel.org,m:igor.korotin@linux.dev,m:fujita.tomonori@gmail.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rust-for-linux@vger.kernel.org,m:linux-modules@vger.kernel.org,m:driver-core@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:nova-gpu@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:kunit-dev@g
 ooglegroups.com,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-pci@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[linux.dev:query timed out];
	FORGED_SENDER(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[46];
	TAGGED_FROM(0.00)[bounces-307097-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,garyguo.net,protonmail.com,umich.edu,suse.com,google.com,atomlin.com,linuxfoundation.org,gmail.com,ffwll.ch,collabora.com,arndb.de,linux.dev,davidgow.net,debian.org,kernel.dk,intel.com,android.com,vger.kernel.org,lists.linux.dev,lists.freedesktop.org,googlegroups.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:email,vger.kernel.org:from_smtp,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FC2A7490AD

On Mon, Jul 13, 2026 at 10:48=E2=80=AFAM Alvin Sun <alvin.sun@linux.dev> wr=
ote:
>
>
> On 7/13/26 16:16, Alice Ryhl wrote:
> > On Mon, Jul 13, 2026 at 02:45:31PM +0800, Alvin Sun wrote:
> >> Module types now live in `rust/kernel/module.rs` alongside
> >> `rust/kernel/module_param.rs`. Update the MODULE SUPPORT file pattern
> >> from `rust/kernel/module_param.rs` to `rust/kernel/module*.rs` so both
> >> files are covered.
> >>
> >> Cc: Petr Pavlu <petr.pavlu@suse.com>
> >> Assisted-by: opencode:glm-5.2
> >> Link: https://lore.kernel.org/rust-for-linux/8ea21b29-9baf-4926-a16f-7=
d21c5a1a1b8@suse.com
> >> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> >> ---
> >>   MAINTAINERS | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index e035a3be797c4..74733de3e41ee 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -17984,7 +17984,7 @@ F:   include/linux/module*.h
> >>   F: kernel/module/
> >>   F: lib/test_kmod.c
> >>   F: lib/tests/module/
> >> -F:  rust/kernel/module_param.rs
> >> +F:  rust/kernel/module*.rs
> >>   F: rust/macros/module.rs
> >>   F: scripts/module*
> >>   F: tools/testing/selftests/kmod/
> > Is there a reason why this is a separate commit from the commit that
> > introduces rust/kernel/module.rs file?
>
> Gary asked the same on v6; `git log` shows MAINTAINERS changes are
> conventionally
> standalone commits with a `MAINTAINERS: ` prefix, so I kept it separate.
> Gary agreed [1].
>
> [1]:
> https://lore.kernel.org/rust-for-linux/DJJ26195JBS9.D3DNLZPRJYO4@garyguo.=
net/

Ok, that's fine then.

Alice

