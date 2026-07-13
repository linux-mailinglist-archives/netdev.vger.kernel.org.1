Return-Path: <netdev+bounces-307291-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g15fGllfVWr+nQAAu9opvQ
	(envelope-from <netdev+bounces-307291-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:57:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8EE74F5ED
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 23:57:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=E84QfuNT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307291-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307291-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFB88302811B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 21:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B8436C0AB;
	Mon, 13 Jul 2026 21:57:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A425369D6D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 21:57:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979861; cv=none; b=PxwUyuQlZoQ3OIdcyUTDUrcFIQaPF7W/zpuu9d0g9cf7Rf8Gdl3xWr4YPaPfe3XtLvZ5cV0K/XwcurqsWdaDZbR0039aVuxyj6+14OYdHRc47Ls40mGZsDs+vIpJ2PkNawXxkmRKZnKTNhzqahP02ieHhKy7og652zEBDiDc9fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979861; c=relaxed/simple;
	bh=l2HeouvYQiBlOik9N5RDS+J9OXY/j0FBrbam0gPdL6s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bJX6C5TxTli5Sq1U/gvrFPUCEKcA9y1yMN+a/8o6JgPMzP3zuTv6MOknfA8qwt1Bet3SPjf3Z08tvYoter1aKeakDNGoWaeLXvuKsM1P+wm/SjDEp3V4X9roUYlq0srdoGnPoK7SiJnDUxyhGH1bfxNLkIzwyB0H1Gt13ISJ4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=E84QfuNT; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so46209965ad.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783979860; x=1784584660; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=At8KsE6lJsmXZegcPrwsTNDpPIz3pgQ9ysWfzm54lJA=;
        b=E84QfuNTkz6WdVH1avsdSoTlQ9lmJWGb0uu7prs72OZs3M7CnlA1ZD6mkuh6R3YKeE
         TLSNe7Ky9y6vRiBs3sDjTM4c6iv7kEI1brlHmE69ohfGCv/hod7QUEwXQOIYIorrO4tI
         Jmv8VhdNnc/wTYOoWXfUa567CMNerMw84kq6BJRatrhJVC3KplWSYCTz8Sfkl5zW1bWG
         v87gfLmavbi0HOp99tDxSlUKXlN0wd2vE5dmuehLeHbf3nerwVGzOaqP7yfZZU7WPkT2
         41vz33kzG5vWfWIJrs+wqlQ6ikS8d7VCNQBHlY33f8dKEdgrbSnGOPa0zTW/2pIpwfGb
         ex3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979860; x=1784584660;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=At8KsE6lJsmXZegcPrwsTNDpPIz3pgQ9ysWfzm54lJA=;
        b=V/oPj9AJl7Ur2pwQB4Om10P9/FwzJf2Kl1sSfziZt38vA0YEQiAu50uJFzBVApDt6B
         ocUv7BL75QnbmzJ8kyTOZvwFoCLyNwqVJ9eNSmdp0wpmcKU4qLGZSdi+lFpnZa5jNu/d
         7qIDe486e8XY7nnFdEYmZJHnDQkG7c5fzprUyauxRLolIWQhad4+IT7dkSddv+ctVmOC
         PnCa5tzzrefM7Vgr5tVNwlQTBL7+GeB9pO2Mh+W96fXSycGCEJUUqkWUNNfK5LmYuvq+
         Y9Jt22l4TR5dm5CQm7Shcp9sVsNiVEc6eQbKB8jUFqxlvQzvBPj2j8dqLvogcPi7K+Df
         Z1bg==
X-Gm-Message-State: AOJu0Yw0MBvZ0C/TXdA85Lh0tY7D6vc1tqxh3L4gZ3l4WKtoSJ2y5xfJ
	m8tcZ/obQta4e33fClgAHdSdn3iHias285LTonp++ZG3GQ9GMOKwr/kXFXR5Hj8Xa9U=
X-Gm-Gg: AfdE7clw1YzQcpWP3BvwfGKnvh517stzW2MLT8SIbl9K7mSPURyEw4O6zZ4Mjt1N3l3
	uj+OWCIy+enwtW4bwMSBiKIWED8FKLxHsaiWV/55Dg1l8zlgUUUfZ9TBVD/bOlpZJuMJxe0wWPS
	sR6H+76kW/EU7oXoAkR2uP38QsNnvOsEj0/5PzHnU1iwWp7yvNFG8cqeAx3SLsRCH8l8TF0HH4y
	wHXipH6ZcFjZyzGpkKhyH+44YGWOg6EZD4ce8CzRgO/KHse3CV+7A/3jrhuycfChg9Y1qF6lXFQ
	73GQpJIIQP5eVVZzLX+3nr7DSrooBVa0miZqv/zpNSJVkq8SCVBXk0TpVYcT/ckd7ppkUwxz6Fr
	vULncJ/g+kBg0xLGt/hjRbcdxvyK1lQDdN+6rp+YS0aoyt1eSHGH4yYeBA7yMU6br3EqL8vzcoK
	6alZhF7LY8utmHBQv3CdNL4tO42xYebv80Gv1MwoPHxw==
X-Received: by 2002:a17:903:3205:b0:2c7:f4bd:91b5 with SMTP id d9443c01a7336-2cee98446f9mr9888315ad.0.1783979859553;
        Mon, 13 Jul 2026 14:57:39 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d57bsm104668175ad.59.2026.07.13.14.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 14:57:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 17:57:38 -0400
Message-Id: <DJXS2WYYPTBK.F3KORRKBRAGY@etsalapatis.com>
Subject: Re: [PATCH bpf-next v3 07/15] bpf: Move LSM trampoline unlink into
 bpf_cgroup_link_auto_detach()
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Amery Hung" <ameryhung@gmail.com>, <bpf@vger.kernel.org>
Cc: <netdev@vger.kernel.org>, <alexei.starovoitov@gmail.com>,
 <andrii@kernel.org>, <daniel@iogearbox.net>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@kernel.org>, <shakeel.butt@linux.dev>,
 <roman.gushchin@linux.dev>, <kuniyu@google.com>,
 <kerneljasonxing@gmail.com>, <kernel-team@meta.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-8-ameryhung@gmail.com>
In-Reply-To: <20260706171918.317102-8-ameryhung@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ameryhung@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307291-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,etsalapatis-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA8EE74F5ED

On Mon Jul 6, 2026 at 1:19 PM EDT, Amery Hung wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
> The purpose is to consolidate the auto_detach cleanup logic.
>
> It prepares for the upcoming struct_ops cgroup attachment patch where
> bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
> (link->map !=3D NULL).
>
> This is a no-op change.
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/cgroup.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index b43f0bff184c..7abbe12e108f 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgrou=
p_storage *storages[],
>   */
>  static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
>  {
> +	if (link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> +		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
>  	cgroup_put(link->cgroup);
>  	link->cgroup =3D NULL;
>  }
> @@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *w=
ork)
>  					bpf_trampoline_unlink_cgroup_shim(pl->prog);
>  				bpf_prog_put(pl->prog);
>  			}
> -			if (pl->link) {
> -				if (pl->link->link.prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
> -					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
> +			if (pl->link)
>  				bpf_cgroup_link_auto_detach(pl->link);
> -			}
>  			kfree(pl);
>  			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
>  		}


