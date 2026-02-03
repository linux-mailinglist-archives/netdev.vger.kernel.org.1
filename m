Return-Path: <netdev+bounces-256480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFTtFIF5gmlmVQMAu9opvQ
	(envelope-from <netdev+bounces-256480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:41:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BFCDF52D
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 23:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D96830185EE
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 22:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEEA3314C8;
	Tue,  3 Feb 2026 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eFHErCUd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57938318B98
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158460; cv=pass; b=lffm38Ey2W5aS5TJo+M3A4nRs54H6Nkpi7R5z7CUn+e73Krfqm+6L1cJ0dalUAWakcA+VTTysYNym/bmP7X87M7VkHtPfpOvrVwyt7iPPIbJnQQkQ7udI9khg36QvrR7Oj9kNx9mR7yr8lFRB7QVgNGDojSqxLggxTkX/0q6Q1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158460; c=relaxed/simple;
	bh=mNxsZIpO12xYwIPhpNLEYqg3xGCJpxHU05Vm1/bMpH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7V7K881DNknw9CDjwoFTXWgjOkLeuHTUHrL2NEFq2uytU8BP3Nh0kIS/ZmR5oQK/pchl+TRRnzx/0/s0JxOPIsFpTium5mve5Zt2mi+m0cFPEP71XkF9o304TIOSrXIJwAKSQMsFk/w5aTGSnpWQehAM8aIMvEBrJvD/mKGM1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eFHErCUd; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a7b47a5460so1285095ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 14:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770158459; cv=none;
        d=google.com; s=arc-20240605;
        b=evMAuqPKBCjUyeVLU2w1GSqKHO675/GnkvQ5jHFfT8SXWp0C9EWqWfDytkmNsJbc7S
         IOrnwQbKk/UI5VC7QoBI5u1brMbi90pFWYrEsdT095vnMT5SoiHzr4An4vFRQXe/C1co
         sFNQxuSOSLp4SlJfXEGk1A95PCxA0SW0rSOtvWpzYugrhOCOY0rMzVy/ZEELXY/+HHQL
         ZzxyzGkGEenC622WMyCHGbT1ZNxNALl6RO+nBG2eNGbw92+NLL8Hka50DY78JG3F2yAf
         KL8mfo6pYUfAW0Hs5mcf/lHQKLwPVV9y5mc2jeVburQf8MyO+tq+fPjJpiJhjUNVYYTS
         fYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        fh=dVtC+irex9MhgjlC116Vhtmy8FWX8E9BGs0VVRlEhn0=;
        b=j5/JPREVzhnQa8b9LnogW0+CKE7HfYtsj8PN3fef2A+cGjf5YpyQ4BmIdCEmHEUs7f
         gha3eLZl+kSwUOI56R7/3che82xNeyMeDu5b/07uAyGgSoyc0fv3nKaZ35UPIuuv/9Qs
         f7WTS1Qd9qxZ2CpBh7kTMbb7oLUDzAT7z/ZnX8pA1et6O3DoG1OfV0UvkajylNQjwlEX
         mtDFKkbHIljbuNT54nuVe1eZjk4FdgAhSyA8xUuOGmHJDMuKbLurYKWhAxum2nd8hBRL
         Lxm0QJVhu+uYNk+gXERpu9s+2fSB3BQYbzLvXTiObN0WrxHXGTegQeuZZcSnDL5SRm5g
         POsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770158459; x=1770763259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        b=eFHErCUdhFyWGykHjYB6biTI6lGhkeyvSU+/AGFo++dYiMonR9D2eLErqPy0mkDw4W
         2xKbh4/DpviR4nmus2RgdGNwaisyKe1eiTPPfwyu2kE7LqIIGidpt/kb68h7YfDfrvgS
         IrT90nehejOP8NrMiJ3XcHBRhXSczmZTklqN8NWV5swtwLwmX3hTf5d63xFjN01BCv6t
         wbuAr8OmZIcI4vBEeLTTE/8sesbRpwy4xw26u+/6906sqyWp0UqEv5VRVuFqLS4ZAjYI
         NgF29kbK+QaYbZ9qaLWDvl7U8mZ0VtIk7dVQ6pXScE/omqo+uz6cRUvzfDm3B37V/jIq
         NK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770158459; x=1770763259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        b=ZyEtJvqjkbEIGh0EWxCK0K0sP3VtcENpn+5b5uF0V6GUlSFrz54C6njkixQUKwHk0L
         sE5GVtCAtmmfALmHh3N7S5HyuA+4uq7O002lSLY2yha8L4NIyM7jL/cnoMTU/7fPJeDB
         GV8w6t2vSu1kLpTOQxgfSVwRyHT6roAR1KduBEbYkhU0qC4HZTbdABKQ6TPyHQC15vk6
         Q70ZpwA3JoZpfXYgMfGwn9YA+/mFstwfOqvPf6Hk7OChCrb8B3JvIwx8rdry/Exy6BEv
         In4gmXQrFOA3sCiheDItW25bJlqcEadrb4s9R7JfEWnr3ul0lqqgIashh0v2aoSddfDo
         Vm+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWWLAfCfQcaL9rE8XGu5gLyfzXD6QDRJYgZghrUht4g6ZdFt93phrxR2+1CzW+7mwAJ1prJCdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzlCkU7g7KrUATggGxcFOWMMKm/kJ2U/hNzrN5tgw4OC8HV6u
	Qd34T3TmbL4Z1grK/GGRbDwltPHXwHaWES4SQlmwjxlNtWT2oE/SViEnJh6Gd7LgzT3zYqxq446
	V8Vx4lwwUYvdGSqKXdg7cJd24OEBUJzhzsL63vNG8
X-Gm-Gg: AZuq6aL/pUfvpaHDADb/U/64CPpbsBX6HlMqfxMcQYGDKQyeyBwGmOjxqgH6e2zjjKg
	YOlNSeAeYs5lR6RlXZyOPI2NyI1RVFfsQZt5KZoqJWMig88asZWlOjnLSRuvdJh2wFOzfwtd/ae
	nTn16+rU+ZP0frcV11WSlKuBHivpRjNDzyVK3G7HK06ESnjrF3H/zPw3G9ZNOrLyfnDRT6hapnc
	vOg3bJGA9S1Z+Adl9ylDZl03tC1uPi4hA0/txOJ6Zcfn/MbptxYJUK3wXLYn73V/SoMwr8=
X-Received: by 2002:a17:902:cf07:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2a9245acb81mr45534675ad.8.1770158458714; Tue, 03 Feb 2026
 14:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com> <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
In-Reply-To: <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Feb 2026 17:40:46 -0500
X-Gm-Features: AZwV_Qif3yehzpr-f2ndt231BFo5lijgl4EiKO49mjjc8a7vIRsWIa1o9OOEp3s
Message-ID: <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256480-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24BFCDF52D
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 10:48=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/02/02 13:07, Paul Moore wrote:
> > I'm asking you to verify that we have the LSM xfrm hooks in all of the
> > necessary locations to ensure that we are safely and comprehensively
> > gating all of the operations that result in removal of SPD and SAD
> > entries.
>
> That is impossible. We can't have the LSM xfrm hooks in all locations
> that result in removal of SPD and SAD entries.

It's a good thing that isn't what I said.  I said "... LSM xfrm hooks
in all of the
necessary locations to ensure that we are safely and COMPREHENSIVELY
GATING all of the operations that result in removal of SPD and SAD
entries."  I used the capitalization to emphasize the idea that the
goal is a comprehensive gating of the operations, not necessarily a
placement of LSM hooks in all of the functions.  It can be a subtle
difference, but it is an important one as I think you can understand.

> It is your role (not my role) to verify that we have the LSM xfrm hooks i=
n all
> of the necessary locations, for it is you who is wishing to ensure that w=
e are
> safely and comprehensively gating all of the operations that result in re=
moval
> of SPD and SAD entries.

All of us who contribute upstream have a responsibility to ensure the
proper operation and maintenance of the upstream Linux kernel, this is
especially true for individuals such as yourself who have accepted a
maintainer role.

You have identified what appear to be issues with the upstream kernel,
and have proposed changes to address that.  While reviewing those
changes I asked you to verify that the LSM hooks associated with your
proposed change were still working as expected, since it was not clear
from the discussion, or the patch, that an investigation had taken
place.  This is not an unusual request for such a proposed change, and
is something that I would expect a LSM maintainer to do without much
hesitation.  If you are unwilling to investigate this, can you explain
why?

--=20
paul-moore.com

