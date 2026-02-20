Return-Path: <netdev+bounces-259785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHSdKjnamGkSNgMAu9opvQ
	(envelope-from <netdev+bounces-259785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:03:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 115AB16B1A4
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 23:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C36A3302D96D
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E51309F09;
	Fri, 20 Feb 2026 22:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWLBDyKX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DA22E7BC2
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 22:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771625015; cv=pass; b=YzUwTLEFlJbDXUq0pn5cP/5ueOAL/IaJgA1hMYQRTv6L01S95i4mGlKn6ExgFsa3xR/+1ciD6YlixPJVBYiN3s6PeX5molxHcvLSeWMmaYcLebTLBKB4Vjm+Byk5DOR9XZYtFra6Kgyvm+ybFqSiQOQBRoEPoZIVMruesCTBZyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771625015; c=relaxed/simple;
	bh=YHK7TG/rhQ9dNC/DoLt9aBtW9f1BpOyUKVxhgDX3NvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5CSStuHTJMHZZ/H2yCi8zYxSVeT5KqfrINjg9988HnXI3h7WbknrUrY4OHyehFtwaOSeOHzHCxWk4VFZDhMe0WM5ITcWAIXi1A5vohyI1R2FMcJPtzHShTfUIuUFvaCu5vzUa+kXTP9H3ejcAwstoPe6EkuhOS8epIp4i3O/24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWLBDyKX; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-506989e8516so21061771cf.0
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 14:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771625012; cv=none;
        d=google.com; s=arc-20240605;
        b=KSmqppkG+qXJy1Y1KgEnwwzQSPYvE+q6QlRWVCtRlpKPb+gWTwIRvfZHu36PNrPKFe
         btmcJueWPw1LzUY6TAv5v9s/bllTl97RAwOlmVjvSShfcjxv3H5MHDohxG12jRZ0H3sn
         gPQ1wx11/v2NcWMRrHrvU/3G0Q3yhfTKw9rtU15Ilxr88DEerVm2O8XI886CEHBkhMdS
         StRC3r+exJ/y2I+qEIAtl29cMUEqBf/g3wibMp6a6vAB2jLmGQZOm/Gu8Y+rU5lDSbWO
         pcMjcrqFQq3QokcT4jo2peK90llA2jUMroA8FW72H3LhFqz7UbuyKvQx98fqOfJl20mM
         SNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pkW8dejlUJ9DbjLeQmKbeIuKQ13t2X0jfyHfctby38o=;
        fh=R32ylRPD17fp8fTJSIT4fHRpYLzzTbxQs1Ud0UM2YO0=;
        b=MdBJ3lkqYYcj6vEgD4mC+Xu14wdk4haXwFsxavZulE2jt9hBZujH+JgH9RXxNvGZs2
         yCfQ6pnkEsUG5eXd6mPV76vDEl6dwdzmwcpbMUNwLv9NqzJwvjyuzCMaLLF3zDOJkkDI
         9c2ot1QwCW6SbhMabeagX5Wt7iKIhakCiprTnhc3u0YLZy8l1UPQKqg2Hg6AbRlQ+fSt
         di1Gsjw8CPZElvNQZSI8yv1+UJ5UL/5ah1uX9uvH4OMb+/ywlx2MAtZ45SxeQYKP3Dwk
         VcBB5XcwfwPr0aVHw4MTmvKMDD03k1fEhpPidTKGoHkNqlUOx8vbtSA0TxR35LJp+T3g
         BaPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771625012; x=1772229812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkW8dejlUJ9DbjLeQmKbeIuKQ13t2X0jfyHfctby38o=;
        b=pWLBDyKXrEAFvA0RnM6CE328xyo/+8Id39pZdNk4iiYJPkwk6jMJnBKrSWBLR8YzWt
         WDz3nazhjTx6wLq/juf3/6PljeeqygloVZXL2yD3zaVRomtk82/x6vbFFoCN5RjOWzQa
         BEyRTLtrSMwsYVxr3iMCZx+b9MWHuj2ktc4s1iiYKp29GOyY5mDBQYoCyUaaUNcU19Sc
         3LoGzpkxDJkgJJndU2wj4Ejv9b3kQWUNd1jGivjcGVDSvAe5+MzLBxjwjn6Tf0OXNGTc
         NGlU/SpMSlq/zTPwv82srLUi4tIRLsEh1bQ+uRCSns9SvbleOahtts5+wbJwUNQz/+6A
         dHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771625012; x=1772229812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pkW8dejlUJ9DbjLeQmKbeIuKQ13t2X0jfyHfctby38o=;
        b=UqEUWsp3ILy+hJKVsUobLdtxWFE4W2wpvK1JHdziJ22NZojex/oooIxCLaVa7oWNyB
         p5R577JVeUVuSWEBUKi6uVjkb3fmXSK1WnrZoi7iVkYuIw29kgpq+2BrmnDt+NzfRxE0
         090yR6WrSAsxm2cBy5pG/aWgV2xU04ALleecjq7PovPu9FT4jCGgcnM0QdWmUrArqwes
         xWlKSQeIgk7UKyBbDmssneHgm9q+f+nVgLs+YfTq0ovgamf5dB9x7Zh+oYQ4qb9PZK3O
         zNwEd9FA/PmH8908pfP8L2Ef0pl4/JNbRi7PEIEfpNth1PTQya5t/LFqe3E2uRa96ay8
         2GKA==
X-Forwarded-Encrypted: i=1; AJvYcCWf40UgVLfp5FrDYvV9QfcB8GjhwF/f9m4ZSlOntAxNxO6AJxZyYf1z7o92ReiKW/Tqxo58UEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG7mgRmlBjFixij6GNnwtXoZ/TSQzxUxw+GnlJoOmTab7Q3Gj+
	eIJUAV7BjNZRb4RCYi6ivDdErm4yXx0ti0+oqLi6kFGhCuLE7tGzZiLWb2H901UCfu7wiZd2vR+
	7/LRPJBGlh7WQv8gfkNERBGf2Y9j6ULJfvuanEfuX8sFKGTICPYwt7AiO
X-Gm-Gg: AZuq6aJedaV69HGlmOmroc1Rg8vXYvG6j7YIFVAfdtb7czQy2tiLF16XhZhBiu1MuLn
	Hu+jtRZnDDxVC1c1qAw8H5v/uv1J57OYG51nWIi2QCsm5k7zFjvc7w/KDp+EWeac+a9KEAEbjIt
	yuFIE0yHTZ59dWJEAMPkIfwmCyUE6eam30YI7c/XlkKweHs7SzeXHJJKSSzJ4WY1+8yQ4A6JRwa
	s+94Jv5cSBiMtyE5+D6N+4YU/4uV83l7if1DNCprrA3Y1PEBIaSEm1nncq/YiiVzSz44TzPJIAN
	8JqJDz8=
X-Received: by 2002:ac8:59cd:0:b0:501:3df2:fd60 with SMTP id
 d75a77b69052e-5070bba4d07mr22613871cf.12.1771625012054; Fri, 20 Feb 2026
 14:03:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220144344.2548121-1-edumazet@google.com> <20260220215209.3209259-2-kuba@kernel.org>
In-Reply-To: <20260220215209.3209259-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Feb 2026 23:03:21 +0100
X-Gm-Features: AaiRm529Ag5lF5OAo3PLyLIFjOtCgkH4oO3CjXJI7Kxu1ttEIte_gNnjMg_Dp3w
Message-ID: <CANn89iK89etMmr5xe_FQSmtjBfoMGmkGT1Vj8hifCwFmhFGObA@mail.gmail.com>
Subject: Re: [net] net: fix potential out-of-bound access in set_rps_cpu()
To: Jakub Kicinski <kuba@kernel.org>
Cc: willemb@google.com, netdev@vger.kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, krikku@gmail.com, horms@kernel.org, kuniyu@google.com, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,davemloft.net,redhat.com,gmail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-259785-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 115AB16B1A4
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Hi Eric!
>
> I'm attaching the AI review. It's a bit long, I stopped reading
> half way thru. But looking at the code I think AI is onto something.
> We have fetched the flow_table in get_rps_cpu() based on
> skb_get_rx_queue(skb), but in set_rps_cpu() we are fetching the table
> for the target / next_cpu, which we make sure is _not_ the same:
>
>     if (rxq_index =3D=3D skb_get_rx_queue(skb))
>
> ---
> net: fix potential out-of-bound access in set_rps_cpu()
>
> This commit addresses an out-of-bound access issue introduced when
> set_rps_cpu() was reloading rxqueue->rps_flow_table. The fix passes the
> flow_table pointer from get_rps_cpu() to set_rps_cpu() to follow RCU rule=
s.
>
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 096b3ff13f6b..7c5e69c771ca 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4993,13 +4993,11 @@ static bool rps_flow_is_active(struct rps_dev_f=
low *rflow,
> >  static struct rps_dev_flow *
> >  set_rps_cpu(struct net_device *dev, struct sk_buff *skb,
> >           struct rps_dev_flow *rflow, u16 next_cpu, u32 hash,
> > -         u32 flow_id)
> > +         u32 flow_id, struct rps_dev_flow_table *flow_table)
> >  {
> >       if (next_cpu < nr_cpu_ids) {
> >               u32 head;
> >  #ifdef CONFIG_RFS_ACCEL
> > -             struct netdev_rx_queue *rxqueue;
> > -             struct rps_dev_flow_table *flow_table;
> >               struct rps_dev_flow *old_rflow;
> >               struct rps_dev_flow *tmp_rflow;
> >               unsigned int tmp_cpu;
> > @@ -5014,11 +5012,6 @@ set_rps_cpu(struct net_device *dev, struct sk_bu=
ff *skb,
> >               if (rxq_index =3D=3D skb_get_rx_queue(skb))
> >                       goto out;
> >
> > -             rxqueue =3D dev->_rx + rxq_index;
> > -             flow_table =3D rcu_dereference(rxqueue->rps_flow_table);
> > -             if (!flow_table)
> > -                     goto out;
> > -
> >               tmp_rflow =3D &flow_table->flows[flow_id];
> >               tmp_cpu =3D READ_ONCE(tmp_rflow->cpu);
> >
>
> Does this change introduce an aliasing issue in the CONFIG_RFS_ACCEL path=
?
>
> In get_rps_cpu(), the flow_table parameter is obtained from the receiving
> queue (dev->_rx[skb_get_rx_queue(skb)]) and rflow points to
> &flow_table->flows[flow_id].
>
> When this rflow is passed into set_rps_cpu() with the same flow_table and
> flow_id, tmp_rflow is computed as &flow_table->flows[flow_id]:
>
> net/core/dev.c:set_rps_cpu() {
>         tmp_rflow =3D &flow_table->flows[flow_id];
>         tmp_cpu =3D READ_ONCE(tmp_rflow->cpu);
>         rc =3D cpu_rmap_lookup_index(dev->rx_cpu_rmap, next_cpu);
>         if (rc >=3D 0)
>                 next_cpu =3D rc;
>
>         old_rflow =3D rflow;
>         rflow =3D tmp_rflow;
>         WRITE_ONCE(rflow->filter, rc);
>         WRITE_ONCE(rflow->hash, hash);
>
>         if (old_rflow->filter =3D=3D rc)
>                 WRITE_ONCE(old_rflow->filter, RPS_NO_FILTER);
> }
>
> Since rflow and tmp_rflow are derived from the same flow_table and flow_i=
d,
> they point to the same memory location. After the assignments old_rflow =
=3D
> rflow and rflow =3D tmp_rflow, all three pointers alias the same object.
>
> The code stores rc into rflow->filter with WRITE_ONCE(rflow->filter, rc),
> then checks if (old_rflow->filter =3D=3D rc). Because old_rflow is rflow =
(which
> is tmp_rflow), this condition is always true, causing WRITE_ONCE(old_rflo=
w->
> filter, RPS_NO_FILTER) to immediately clear the filter ID that was just s=
et.
>
> This means the hardware filter ID is never retained in the rps_dev_flow
> entry. On subsequent packets for the same flow, the stale-flow check:
>
>         if (READ_ONCE(tmp_rflow->filter) !=3D RPS_NO_FILTER)
>
> will always find RPS_NO_FILTER, causing ndo_rx_flow_steer() to be called
> redundantly for every packet even when the flow is already steered.
>
> Was the intent to use different flow tables for the receiving and target
> queues so that the filter deduplication logic could work properly?
>
> > @@ -5134,7 +5127,7 @@ static int get_rps_cpu(struct net_device *dev, st=
ruct sk_buff *skb,
> >                     rflow->last_qtail)) >=3D 0)) {
> >                       tcpu =3D next_cpu;
> >                       rflow =3D set_rps_cpu(dev, skb, rflow, next_cpu, =
hash,
> > -                                         flow_id);
> > +                                         flow_id, flow_table);
> >               }
> >
> >               if (tcpu < nr_cpu_ids && cpu_online(tcpu)) {
> --
> pw-bot: cr

It is indeed very very very long.
I guess  I will send a plain revert then.
I was trying to fix the patch, but it appears it was completely broken.

