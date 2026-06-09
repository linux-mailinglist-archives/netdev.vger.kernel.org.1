Return-Path: <netdev+bounces-296935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aH/uGH3AJ2o11gIAu9opvQ
	(envelope-from <netdev+bounces-296935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:27:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C35BA65D2EB
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 09:27:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=d8WYmlDq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296935-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296935-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EB923053335
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 07:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466733BF684;
	Tue,  9 Jun 2026 07:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859D33BFE4A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 07:22:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780989772; cv=pass; b=gBa2UikxFYOW920b7haz9zc/j+QfBg7ariJpez81iiM+3gbUQC5gar/6m1Yx2R1TrrXb4/bZFUP4AdXuszQrUfpvYWmUAwwPfUMd7rfLpUllHPCfj78PRIeXIl3Fug5wP5ythiAGnrw3WcHwkZi43WC7FKDgev3U6PpbElq3x7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780989772; c=relaxed/simple;
	bh=L2fJeoj9ZckODw6I+JHP0ss2IJ6JLk/k6cCU+U5PeT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8ifR/iYTwWJXLImUCW5iV/znBLQmvEChQUeQWstFC8W5n6YMKXuWiS58M0ZKoubb+WLb5xONdt8xmfTWBggV+zQdZVoVBu5P/qcrb1dhd7m+8Sa0gVuRd1OBpYk2SbCg70GHT7iBI5wihoefuAAoBXee5/I5k775zCeI/RRkno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=d8WYmlDq; arc=pass smtp.client-ip=209.85.210.180
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-842307473b5so3466537b3a.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 00:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780989770; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4q/ssbRN77SEetmSVm5W+5gOZX+fjQDmm9hkNQYPlHwcoNmykk1IonqoA/NFhvUb6
         ikl/oe5AVptiHgL/spUBdLKzeH8fU2kaXuXPUaxueOI9y6kp+pK9WMfHtNM2KxlFMmbg
         3dPGLnXTnyFbOdUaPbPzcZICfgmbn/rHmNh/LURdY6vv5MdEY0Te3p4U757BK93dqv4u
         xD7p1s+9HI2+Ce24SfNbRQ2z8I2BwCDaBcw+mgfPS8kQA8kQudf0OzEwjreOZk1Vyqhk
         7Dhe3fM6dy1qDzgb6ccykyRWuIWZEMU+lX5iIjsW0rrglzcB8+AD9SZIpFyjaDx/Mkb5
         t1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XhzBDyqhqWawgeb7Rpt+eyD0SfA21gLZx0HZ3QvwY44=;
        fh=Mg9jDXqFMKeOg7r2+GGGxnPpAqeyx0tiXTEeP/qf4Hk=;
        b=KNGKswOUTrSreRmJNGjjfZ1CH5zTlBjj+tmnveQ5gHWwHMoyZ7aBHtO/Hy/43LXtmi
         8EoBwTXUA0Azsj2liTNShI6hTno7wbZrzU3cmP5GUCuvKHGazTnlHbelPw6IbNcRiRyA
         F9v5dc4Z17iot3fWb13+zSLSdjwicv7szdkC/Yfn/GZZFULydpjNY9+HQ1m83aq2TMkU
         J3eCumBqnPpFAVoktnMyE9runWwEhNfkQv1zLluwVQUY07BEaF0ZZ6/bw32Azu3iqfZp
         TYm25mhSe7PW72T2RSUkvBkN8OAjJvhmy66g30VhLeuseeZCMnPNFGiZIwX4lAwFMj7c
         K0Nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1780989770; x=1781594570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhzBDyqhqWawgeb7Rpt+eyD0SfA21gLZx0HZ3QvwY44=;
        b=d8WYmlDqXkSlE/QEFx0x5mflHGxP7ppxr6GAKaX1eVaAdRqJMv63iVIzXAGm7koVB1
         LBEHQjTB+aaF+qto1yW1VRorG5W7iMTrBy/GkqzVlfvv/5BbruTZnCqIYb6SK+UMdTWd
         CxvMPm9uvizxcHejuismreqqdFGDREDeA3Bb6e9PhFEZordbR3UuTLUeYvqBzj8YzvaZ
         3OI7w+CgrNdh64Jlvln3fJjZBZ0wrhybWBOY2J4gRAh0kXJDK+L+wNeRsgjLbF2kDXE3
         hvH7PRU5Flmh4jjllOteo3lIuLc094EDG15RXvHgOpcD1UvUFnS4nzWNN26LaD5w2Z4M
         Lirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780989770; x=1781594570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XhzBDyqhqWawgeb7Rpt+eyD0SfA21gLZx0HZ3QvwY44=;
        b=cSoe8G6p6mYdwg6jLSgFlMPgKCtqfpcnkx4ePUVpeQzQnkruVAEr6wwm7T5sPA7TJm
         6DxD28HrIy4biPX3TCZ0UfyC7tT+qLl5vqZ7uylj2m/+m7bJsEgpuHbNdzRlWSQoZ/QH
         skseM2qrtY87Em9FsC8FYCejSztT1n9ZyZpO4Mp9IHH7Ygq/k5Xk5aP/DgGAiJu/SJYT
         tpdOLS+rleCW/vKVm9vSoRquxoYKJ5wNkHaLZEBLHif0jl+eGM+lMdQcydYaxLnhVRLD
         v8PVY7EfjTCl9fU9/65IuQZEmf7E8LUL81EtfygaCAdcrBMG8GF4y48Uuwxplz5QRjoh
         WHrw==
X-Forwarded-Encrypted: i=1; AFNElJ++R0WUavvhzF1StJkh0b+1w3NcEGQHYUAbM1C0IIf5NN6tK9E5A3Bv2CIOzeECjFxe7xuuvyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEr2Qwjovc0bfemF+VzLVyPGnCVotY3dBBUSWvgg5SOft/QXHy
	fZpM2hUWZOAYcvViMAcBobtXktKrK+6heko6MWLBhOtq1Mnsrez05+++kDrwk8ekVKnwnZqchDS
	RazDek138n5Yhe/3PjPz5bzTRvH2vHTFOZuD1zuWm
X-Gm-Gg: Acq92OGyM5P/+vlXTU+u7l7TANDHgF/1/ktAxDmhkOnDJs7QjgtcWVCVybC1F2byAwl
	U4Z1PnoyVGplMa4HxlMUnp3msj3DkqntjlnzYrX/wBfmekTBrwyym32xMNCI9hfYGkNa9297dEv
	50xp/TlBv3v7jgI+XAZKBFt4cGJeT8TT6liU4GTNaBUYYER5OMd9mAQiZfiHOK4w7rhxFBLLEZ+
	pxnQEAVIQ8aJzejDuVpyNFDO/Fkvo5E8AyMh5Lbz/aA3NwnwwwYVpznz+CYMuxR3ey0BNUSABRq
	b2EhisV3jih9p/YOkg==
X-Received: by 2002:a05:6a00:2e18:b0:82c:6aee:b21a with SMTP id
 d2e1a72fcca58-842b0ec6826mr19358557b3a.45.1780989769886; Tue, 09 Jun 2026
 00:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606215848.1951633-1-xmei5@asu.edu> <20260609064613.GA652158@shredder>
 <CAPpSM+QGAARoC2Jq2EfMkXCgBQXy7k64W6rBFdJ8mhpfrR0zXA@mail.gmail.com> <099ba3ba-49af-4ed2-8b58-31f8132f0d32@blackwall.org>
In-Reply-To: <099ba3ba-49af-4ed2-8b58-31f8132f0d32@blackwall.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 9 Jun 2026 00:22:38 -0700
X-Gm-Features: AVVi8Cf1pKtYuSzwyuVqnoD65scraW516qZkZNa3AxiW1AO5tTzX7XOZgeq8pmc
Message-ID: <CAPpSM+R1nbAwJ5oxd4csVhwPHTVLo51DCEcM2Chm+s6oh-G0+A@mail.gmail.com>
Subject: Re: [PATCH net v3] bridge: cfm: reject invalid CCM interval at
 configuration time
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, horms@kernel.org, 
	bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:razor@blackwall.org,m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:bridge@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,kernel.org,lists.linux.dev,davemloft.net,google.com,redhat.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,asu.edu:dkim,asu.edu:email,asu.edu:from_mime,blackwall.org:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C35BA65D2EB

On Tue, Jun 9, 2026 at 12:19=E2=80=AFAM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> On 09/06/2026 09:51, Xiang Mei wrote:
> > Thanks for your review and the tip. V4 was sent.
> >
> > Xiang
> >
>
> Please don't top post on netdev@.
>
Thanks for the tip!

Xiang
> Cheers,
>   Nik
>
> > On Mon, Jun 8, 2026 at 11:46=E2=80=AFPM Ido Schimmel <idosch@nvidia.com=
> wrote:
> >>
> >> On Sat, Jun 06, 2026 at 02:58:48PM -0700, Xiang Mei wrote:
> >>> ccm_tx_work_expired() re-arms itself via queue_delayed_work() using
> >>> the configured exp_interval converted by interval_to_us(). When
> >>> exp_interval is BR_CFM_CCM_INTERVAL_NONE or out of range,
> >>> interval_to_us() returns 0, causing the worker to fire immediately in
> >>> a tight loop that allocates skbs until OOM.
> >>>
> >>> Fix this by validating exp_interval at configuration time:
> >>>
> >>>   - Constrain IFLA_BRIDGE_CFM_CC_CONFIG_EXP_INTERVAL to the valid ran=
ge
> >>>     [BR_CFM_CCM_INTERVAL_3_3_MS, BR_CFM_CCM_INTERVAL_10_MIN] in the
> >>>     netlink policy so userspace cannot set an invalid value.
> >>>
> >>>   - Reject starting CCM TX in br_cfm_cc_ccm_tx() when exp_interval ha=
s
> >>>     not yet been configured (defaults to 0 from kzalloc).
> >>>
> >>> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interfac=
e.")
> >>> Reported-by: Weiming Shi <bestswngs@gmail.com>
> >>> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> >>> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> >>
> >> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> >>
> >> Nit: I don't think that the Suggested-by is appropriate here since I
> >> merely had minor comments on the previous version.
>

