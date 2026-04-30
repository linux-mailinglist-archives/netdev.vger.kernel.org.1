Return-Path: <netdev+bounces-282989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KQvGp/C82mw6gEAu9opvQ
	(envelope-from <netdev+bounces-282989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:59:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E734A7F8C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 22:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82B623020AA0
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 20:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83DB3A63F8;
	Thu, 30 Apr 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HRi5Ngjq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FA3783B2
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 20:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582733; cv=pass; b=kPrRWjCAMAI04D/syh6ey2c9MtsNvKmwrREvJLUA4jtb1xBPF11Gx0JKJi1tlgpWMdyjU4M7s4hocFMG0tHETPX33VYDYTlU3t65RU8WHi1NFRf2nE1N34fp4uwafe/lBwNHRk6vJMGmBf8FGUc62zJp3x8CdoQQkd6xPQ8R6vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582733; c=relaxed/simple;
	bh=DZm88FmcH8LX12G8Lj00Yhlmj5kB1D8w1Kmsk4vwxIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHkDD5uCIjmZHpIUx2Lw40lafxdrTI/t+5w27AFZwQj1y6S/AnihefU3aYAkSt2l8P+3jbMJzoSwYozvT7zqkDftmZMRwZOTp9FoM/43FvIXiR9GhyJYhKd1D3vIluB0dfBBFGEz1KBccjO91EUE4DmBt5uC7xmRjONJcOqfCfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HRi5Ngjq; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-65890a6ca20so1432140d50.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777582731; cv=none;
        d=google.com; s=arc-20240605;
        b=MgeTWHnsamYQ/Z9uTm9B3dwzjKknlZAKp9EtyfEh2faecq5eBcpS6+GQo+6DE6JJBq
         s9kAg44w3Q0VCzLXhRn1zIbmjWW3yqtd2y1/sF0jWhJ7sadweOyMySU2kWyyb+WKHOoK
         EQXGQLtuJFUIclswr3EAERM6lY+0J2Ps8TLo7lbcoc/cYwN/U8r1SliB14aJ5f9YzZpN
         rA+Cr02jc7hPwdW6RIgElv7cBwl9k3hEFXAJkhdtcnWRY9R92iQaDgxsnm7pTog7GcQI
         /QVeszafzS7h0UAYuuR2TM6GDPNmTA/tS8bUFvJgxMnOiYle/dHw5C18MgR4NVUvyy5L
         fqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hEnpSpB3eFO8NuC3B8ExUkCQEnerNqs6qb5XedqR3wE=;
        fh=GpV+c7upuF4kmO/xoVtWsew5MoC0pqLi6S/Or0wUf08=;
        b=Ept06KcU3LhrRHFH+78oSf99w0f6Y83GyqO31VTtbvDFS8q2L0tE07xFoAVGPN+W1b
         mefK3t9dMXcO7cmNz64jjaafUPTZlRkdWWx4H1dX90qN0ZXFOabKgOsR6jIoubXWCP44
         y+cGqm1rf9VK7h/dyoVZkfjveNlEbVgSL5o/TYW1O3vevc8CmOTtQACjLGTy092gaa/z
         82WRmk99XBaz+aw0DbXYwoB6TRH52b98Je52kGJClRhEH6xmk8hoZHw/L704CzagZu3b
         BU9+6ohLyEWBpQqbmbToxxHQTU4SHXYp8qiElgGOk3mkpOHcV0utSaiJcQNenPpHqHdy
         CYow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777582731; x=1778187531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEnpSpB3eFO8NuC3B8ExUkCQEnerNqs6qb5XedqR3wE=;
        b=HRi5Ngjqb56ijwc2YXXzEZlot5RNqjlczTMFHwWzl7s67CTkXm2IGAySetX/i/lCST
         z8HjGsPM7yCW36u3X49H0yf+Nf4hW5Ph/6YiwUb3ke5mTk/2IMaxS3DaXlxJE3tM/TM1
         M1kR/n9XMCzKEhs2CW0cAYcOmGuDaXRI2TE/KCpBH4+Q/0i8VAIoQxjos3dHLzqwNxUj
         BlE2IoTloLNGlwBhwNhcByC2hTuX8ub6jkdcid1cQDVnO0hPbRlkETeqrZ8PnNXEgkhv
         r+sZh2DnXS6UEf5lnNbcEQR8ZOB+h+R6IxYT4cewRLZW7uPPPSmWDQtr+M81GEDObUe+
         mXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777582731; x=1778187531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hEnpSpB3eFO8NuC3B8ExUkCQEnerNqs6qb5XedqR3wE=;
        b=VkjyFKP9okUFV7hLspUrgfLQ6TQv6FRXPuYqcbppVmdGJ6khLOWjRPIirgELtBlnJR
         4l4BT4ZUFSSRgUkMlsKKJ19hDgjXGlw3Zev6rF/CI049ndK0B1l+toaKLytqmSZw+w/5
         +dQYIkbv/kTkgTngRT0lN7CdQRQ+n+Xs0X4CRkSBA0CRvxNYp5m5ei47C2odRkY6XR8X
         BD9oRa54/2hGWELaed1/Yh7b7Xi3X8bef88g161+tw4QF+Kw7Vfv7gTJ6Y2ERkzN7bgp
         I/GFn/dA6GGnHLI/Y92kGlg5Hs/MRIndfHTe7CGWO5ZGSUmu8MyxwuYBtPD97E/XGHRJ
         hihw==
X-Forwarded-Encrypted: i=1; AFNElJ8BkSRO6hSh6aPgh77X2fJdz1Ncz3NAtGm2t5qpfWPepOd+KCn9lEZHGfDMBuxVHvFiq2rnw+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuebi7TYwSM/RimRRY+Wc1WDeP7EfZV2IS9A2ft9fYmFaD3Deb
	BqANon76h/D50iLfmPC3J62GFMMNe2UnlG7TNaUdPPVuNeRHlvJNjV1yK4y9MMJwTEz8B08yzxo
	3rfSJEHh3D/UeQtv+ecAmPO3WAVNqpdpzJ1sImaxD
X-Gm-Gg: AeBDieslB8nwB0oVjNf2kNSdbD37HGfDLavSg/VJoYdxr0Hal4p7hIeIo9ypgu3w4ct
	nd1GhfKZifUFD5aSLpXJDRST1i+ITL870t8/15jI4imVpMChtBhm41QZ0WDifHHuW89UxBYls+F
	a+HLDyETgXcDlJtUEIMBQUD++H42S01sOP49jCuYfQSopznT5bpVG7RIj7s+xyz0PqaGo8NSIfb
	CJ5aquW6/j3ZLAxsnPnLsxqDRS80fpEo402NRLMkIdXJ5HGaYYiAj+GzObMeJE+duQ7B+/GeBjV
	djU88Vvr0X6Af0KlEuy6K+fPpWlJ1X8n+/D6eeX3rSglCT5ebxwR5u7F1ZU=
X-Received: by 2002:a53:ac83:0:b0:65c:2ac8:ec3a with SMTP id
 956f58d0204a3-65c2ac8ed74mr1612608d50.21.1777582730691; Thu, 30 Apr 2026
 13:58:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421051641.370436-1-boolli@google.com> <20260423163307.989421-3-horms@kernel.org>
 <25163a38-53b5-445c-936c-0cba94cb731f@intel.com>
In-Reply-To: <25163a38-53b5-445c-936c-0cba94cb731f@intel.com>
From: Li Li <boolli@google.com>
Date: Thu, 30 Apr 2026 13:58:38 -0700
X-Gm-Features: AVHnY4I8U8-NSsj-bnIoiUgXgoUy_jiPXyvaEaAv_OuN_FcN8_8wmmTGL0lyL7M
Message-ID: <CAODvEq4R_7SXfo5QJ0z=fM5npz1ZFFcCQTTKkdoLKtXyoDnjRA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2] idpf: do not perform flow
 ops when netdev is detached
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, anthony.l.nguyen@intel.com, 
	przemyslaw.kitszel@intel.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@google.com, intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, decot@google.com, anjali.singhai@intel.com, 
	sridhar.samudrala@intel.com, brianvv@google.com, emil.s.tantilov@intel.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C9E734A7F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282989-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boolli@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]

On Thu, Apr 23, 2026 at 11:40=E2=80=AFAM Jacob Keller <jacob.e.keller@intel=
.com> wrote:
>
> On 4/23/2026 9:33 AM, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> >
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > idpf: do not perform flow ops when netdev is detached
> >
> > This commit adds checks to prevent crashes when out-of-tree modules byp=
ass
> > ethtool core locks and call flow operations on detached netdevs during =
a
> > hardware reset. It introduces netdev and netif_device_present checks in
> > idpf_get_rxnfc and idpf_set_rxnfc.
> >
> >> Even though commit 2e281e1155fc ("idpf: detach and close netdevs while
> >> handling a reset") prevents ethtool -N/-n operations to operate on
> >> detached netdevs, we found that out-of-tree workflows like OpenOnload
> >> can bypass ethtool core locks and call idpf_set_rxnfc directly during
> >> an idpf HW reset.
> >
> > Is it acceptable to add defensive checks upstream solely to accommodate
> > out-of-tree modules that bypass core kernel locking?
> >
> > The core ethtool infrastructure manages locks like rtnl_lock for in-tre=
e
> > callers to guarantee safety. Modifying the upstream driver to paper ove=
r
> > locking violations in out-of-tree modules might contradict upstream pol=
icies.
> >
> > Simon says: If this is to address OOT module behaviour then I am concer=
ned.
> >             And I would suggest that the correct approach is to fix
> >           the OOT kernel module.
> >
>
> The commit message says: "OpenOnload can bypass ethtool core locks and
> call idpf_set_rxnfc directly". But if it somehow calls
> idpf_set_rxnfc_directly without holding the appropriate locks, then no
> amount of changes to the idpf driver will fix that issue. It is simply
> unsafe for that to be occurring, and this feels like it just patches one
> specific problem without addressing the root cause that something is
> calling the drivers ethtool function without correctly holding the
> expected locks.
>
>
> @Li Li, could you please explain more details about the workflow that
> triggers these behaviors? If it can't be reproduced with in-tree modules
> then I don't think we can accept this fix.

Yes, OpenOnload calls idpf_set_rxnfc directly without checking if the
netdev is detached first. I've discussed this with the team
internally, and we decided to fix OpenOnload directly, rather than
adding the check in idpf.

Please feel free to drop this patch, thank you!

