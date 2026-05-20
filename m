Return-Path: <netdev+bounces-289761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JrYGo84DWpjugUAu9opvQ
	(envelope-from <netdev+bounces-289761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:29:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB035877D0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94C49300D447
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 04:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14043546CB;
	Wed, 20 May 2026 04:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf/xdFFt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC933BBA7
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 04:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779251338; cv=pass; b=cbFphrcuuh9Y3a/f2mYVrp5A8sdOsro2tNM0rB8aZZn+sLyo4EOzppl8NTYyOoP+VmB7lyAgWDksBJV5RbLwrjjqXV40Lo9p2wnUWXo3xtiiObACe9tkXmcjIIBVl9/pY1iecWiYVG5cc6ETAoM8K015KDniDawWPTD7Qx6qhXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779251338; c=relaxed/simple;
	bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hUgNz1bxxADSK3TGc+zgK+Rq8IKC41ma+ho4iHqJytfm3zCe70KWUc31IORCB/rXrtVLX7EhXC2V5pXtbbs09wOVyv8Qb40GX85/mLVNl5XU8X92+gulwTFchgUrrL6dmFbvwlFDeaIfVhCWFy8jypV4hBJvS7LfKXzIrbn0vM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pf/xdFFt; arc=pass smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so6687568e87.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 21:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779251335; cv=none;
        d=google.com; s=arc-20240605;
        b=B3ERzNduuYJPo9Al26oKwCyFwGgQ+68jr/kUzJySA1CwC3G7jZGznF6+o4fXRnBQci
         fzAGkZIpwaNg9Rc9pZWTd0FR0LIsMhwW+blMHYS9c0BMZiN9dGcB/YAYboT0QfAwOA7Y
         tWJm8dzpR9v6/cFcpZiz/gceRdz45kpF45DgfyFFkjaJJgAOutuyZ4KkhwB+PyhwbByv
         20CbWEog4P+cKBcVC/WplQVw68I3yBzBddClp2CyWEJakGrMNVUXpOo2m4l58jirYNvl
         goeSBGA4rjnHeOOel8XvakedD+5f0+GDaXFZWBPcPj0cs7g2cOQo308Z618yk+nxxeLO
         CkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        fh=Vkfqx6ffHSWACYhd/vBRaRBHvYAcD8YRkCMpVLUdrPI=;
        b=LrHbLHmKm7azkkBfl+GD6PsOEk/mVQBnrWHXIuCFL96mBOMGorxJVB0gx7UUMNyJRV
         03UlPplSrg1oRnU73Bf09UvqvgeswbROx5clbpeYIW7+0MEVtBdmZDFLpyRUxWqLXZDD
         eCiwPXC8u6hKbdsN80ew4H+Ie4AfGX1cPC5yLHEhskmcwZj/Rb6TVwEgfrpRgUtTN95j
         T2Qh81xhzB5N9k9K0i6nf/5pOeHcsEQZ68p2Mb/t6oUBy94uyJ0I0dkxdKeAfFnJ93Fz
         VA7km7/cIUuI94t0IWOi7yO3Fi+XwjlRaX+B+OqVMDPGD8TAB9sKuzzhYVIakhS01IRw
         UNJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779251335; x=1779856135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        b=pf/xdFFt04fdFs1N64CxC0xgaN2rRfa5Xp1aYJ0hEr0FlVQTG4l5JqWGzdYZxJai5O
         Q/PjDVKIg2BSkneXzSmJSgIIqHTVYLZJYj/Cx27CnPMhQltpP94bGk6zFv4n0ln5Bouy
         WnerPoDC9NnQfRUyilijsVOURO4dzwFlAfxIiPYZn1EHa4uhjt0kH8tGAKD8098ByXM6
         xnmm2kNQ2bUL3sHFZXHKMezzgrg/jpNeKN3kBpzTKfr4dg/z50C+bEULRrmCGod7mxLV
         il37h52WNVMJlIrMyVfQjKz4m9LGjjL1OeLlO3884O0Yl/Rsk8a74pqQVzE1F77lzvYu
         H8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779251335; x=1779856135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JOTsuNNwm3OUcz8Y8bCu0RJEPYgzgrSgRWrrAjARiQ=;
        b=lkTDrFaeYAg/NdY3Rmrmcq14TdvwKVuMYfUHeDDssJUYA5GhjazRagQiL/SlGEXL8n
         o7Z2im8vfZiTB4Ubnf/eS8XculXlAOEc0+ndx6rE3lNC5berY0N59WBrQWFZsLjRG2Ae
         rF4s33LXVYYgXGoDC8vK9rai1Q+vkRlk9pUmMep5iS1skKfV3+JqijRvRNBA7BPbKifA
         Oax5760h55rxn6SF/VkijxmawTx5Rb+bansIOj7s8obsCCjxsNTdmrF4J07gwRvzOGSR
         1YjTPj7coEFBpp73/FIAwEx06RjpBydRR9HDFYxoOA48Y2FRdL0+OCA+9EALnKj2DAhD
         v/4w==
X-Forwarded-Encrypted: i=1; AFNElJ+Z0P2P/q1rDOlHJvwcypP8OvleyZwyiJODbbwAj7oNWHZqTx29rMiqYkL0UqH38F3fh2sYOJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcrCwUOMn2dYYSNEUvZl/8kc19/dWuUI4zrYK1L+b6v3XB/7K
	uFk4nbYtWopJN6HuOQpn1MUEFHwa/Pk5wILgYIWPl2GsX0M14IyeKvdN8X4SnjdGxhRX7rpuW/3
	VQgTRhBpDZU0Vj9H8eCu1Y+cMrvuv2gc=
X-Gm-Gg: Acq92OEitFGQMdQ+z3VY8govXgGLRxBewOwKxpKWEgMVbxd3rXdfJOlShcBu+Swa9nw
	uleuaEXc3K/MI7ExOWd3lNYVUpM16CuDMEE+Fmu3IYmSq0Yd3/0AWDn/H9PWwFSwBVWvBdclRyH
	kd6cUmJ2FzLl2Y8ZMZ9jJ/P3wABZw5P/v8Dw8w2goCTKTtzIrTmqws70T9qSdb7cdPgmKVYoD+5
	sEl+mkzqsPmVdFgyXcj2bOqdl+2E3GWZU8Fzv9Ok5ELrdeXXGBx8TZLjAUjjm5Fjs24uJbHH3nb
	VhHQA14kF/kfcwTwKbkpz2cC9kFYAA==
X-Received: by 2002:a05:6512:118a:b0:5a8:e32f:6edd with SMTP id
 2adb3069b0e04-5aa0e5baa13mr6949512e87.0.1779251335198; Tue, 19 May 2026
 21:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
 <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
 <CAB7XQsGe8ZA_WRYcGgkOa--f+XdB6d98_g4VedbFPK01eH0rBw@mail.gmail.com> <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
In-Reply-To: <rn5uidhakwmnjb4ngkyvzzjnwb573ie35xu34z4fbmlp7spd2o@hr4ifc4lqcj7>
From: Cen Zhang <rollkingzzc@gmail.com>
Date: Wed, 20 May 2026 12:28:42 +0800
X-Gm-Features: AVHnY4KqC33UsVo9KfyspcxLS3cGw-I0fQb_5ohSI4s38uJsussh1K0hTuQ2Shc
Message-ID: <CAB7XQsEhgsgXTLvE=Dr92Ydex0e3jbZ1CeCs5NjWsJF6yBXn_w@mail.gmail.com>
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
To: John Fastabend <john.fastabend@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	zerocling0077@gmail.com, 2045gemini@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289761-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BEB035877D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi John,

On Wed, May 20, 2026 at 03:29, John Fastabend wrote:

>
> Great. I think its fine to address the tools extra callouts in a follow
> on PR if you want. If it helps get this merged sooner lets do that. All
> the tooling keeps hitting this and we have lots of duplicate reports.

Thanks.

Since we have not worked with the BPF selftest infrastructure before, it
may take us some time to prepare a proper test. To avoid delaying the main
fix, we will first focus on addressing the main issues in v2 and try to
send v3 soon.

We will follow up separately with a patch series for the selftest and the
extra issues.

Thanks,
Zhang Cen

