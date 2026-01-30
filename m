Return-Path: <netdev+bounces-255178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEQ3MxbXfGlbOwIAu9opvQ
	(envelope-from <netdev+bounces-255178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:06:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE74BC60E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CA530210C7
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6391D33ADB0;
	Fri, 30 Jan 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="g7xVbLZU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EF346ACD
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769789156; cv=pass; b=hSWPdSp5G6iDiOVQ6DNr5kd5s8MCbpkSJM1aIWojp+38TN9oZx8DEn2vTI0ojp73oXzKEteBQkoXlDWUC84Vb6yXU1I6RVPCd/4P+35Nxgr8OKgTtSnhWuCHO87TtCUeLPfbcdDEzAwscEREJDkIVXgSLekatC0qjPBXfHpdPwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769789156; c=relaxed/simple;
	bh=4fZnjyFgpIMGJkogD0zANpcfWLMkds61W8vMRGryR5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvpXWxXqKhSr1j7MCnoPqgboPjfVaJxsHlfRBsNyMHzHVKcnFz0tzhXfywiCBQQ8BrobVYQROxpp9UJJrB5IAqtX5s0aGgnQKfxCAZk5kC3a1GHti+1o97f/hbAA6xhIlNXXuslvY2+kGSug7v+R9qJ+PBBH2IpUp8iM+xWRnWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=g7xVbLZU; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c718c5481so1499550a91.3
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 08:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769789154; cv=none;
        d=google.com; s=arc-20240605;
        b=BjkNdm3q1fn8gpWnAS92km9mse3X42ZSzeWOa1oqNgL6gkrDSjZeQjjG3TNSTl9XxT
         zSNKYVpXsw2IQIpytaVRPxfj702xbiGQ2sEPkuCsTl7p/RRIVYZeZgtxd2bNHes49XSe
         8WbS2HnNKUDeUVhrSxmZH6oJu0k7f7vh04fRnAL6cLavamy8FfZxOpbbJ0It/mq3bBDz
         Zd/zNz6PRc70Y4rEnu/qh/2+0ZjhtF1UWvLQXPDn3S9RoQXPFA6vfId3ZxHO4pnVlEQK
         Ha3Gpzs1z0B7gWD54SE+V2vIawP0uUCtagEjHbJBzc43jtRCVCofjtC6sp7etzIqvxF9
         ymqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6lu90wruAlZ/DKcHeoEbrM8yaNL3EZpGp52qKmrPyac=;
        fh=d825hyJZgoaUkZ3eAKRyzjfAo2sQ1Dz7vSNc2ZZXL9c=;
        b=Ulw6gzL7ro1DfQ0StIRurTmjDLIQXnM3YlFrcXZ89Z7wMgdUwtOLI7Uiur/6BJga2A
         JhuUL2lmq+kvHoO0teUyU5yM9/ToRDCSUnX1uho+nsbqPsvQ9UZ1jQvIhCUHIcg+w9N1
         Cav+leiEd2nP2tcMtt4XAcKDMVitwtDvQ6y+SqTjqkBrZz5oAT1zZ13/LyJDbk++H4lG
         mXov8459Nl4ixC8cQLGYSj8dJ1JhKu1CoQyQsom9rfpaXCI5WZJaxsjO7Sz7O6d+AOwD
         dZLL2bWkCUByQciirMWI1XfNSBvClvzdQTLHrTn+DPr+E0uZN9gzCq8ku3y7EVTsHwV7
         +T4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769789154; x=1770393954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lu90wruAlZ/DKcHeoEbrM8yaNL3EZpGp52qKmrPyac=;
        b=g7xVbLZUMoMrhOceMCNCgSIv7TMA36rASU+rz5mipEyuiOpZHQyiBakLY4zV3XCwXB
         SnhA3v9/kG0YKbYuZ1si08BSTmq3f4i9prrSTL8ImtQkYqxMyos8vjKXXA93HvgTKJIu
         LlVAJK5WjJgOfeTocAVbLXXvxGdwYWb+H/mr+LVznJ+AJkc7ZkzZbF82cTXXer1gR8aw
         90Ome3al+H9nkJY7Uc2YLygV+jEjabPG97Vots0O5x8hlDfJOTawnwm/z1NhJUq49wiS
         uRRrlehs9/2yvFiHeRmVdRoLG/qoCzR5K31cqCievyPyNWxCC0x6Ur6NmDJB0S/y1wbO
         S/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769789154; x=1770393954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6lu90wruAlZ/DKcHeoEbrM8yaNL3EZpGp52qKmrPyac=;
        b=q1FssoO7rm0zvSIT/H9g1cPX4qgCSMiaWoGzw+0LIq/la18cJ2GFXlEwhW4TZAw1ST
         xmQvPZzBCCyJVuhNVlW65w64igXhIqaQi5WmRfdTeDsBWgvFDZjaUXHe1dlY1uBwmGDg
         t6pc8WfFkvlDySACXXE5nkVw1nq+d5h8hV0Jbszg3gyh+iy3atvq0s/7de3s6096E2HO
         zLfDvH3BXfpWY1fAuFed+LoTuaIPTgC4LXHHYjhFHcQYhf4JqjZiNjXdqD/urvQKCACz
         O/zT0J+hqr8x8PnCOCJ7kIfi7difZZuqetkiR6u5IZyEIRGFGzNMmVssebsosYaap9Eq
         MuNw==
X-Gm-Message-State: AOJu0YxPTZk99ZKopWuRRoaLUldtYkp17ma/LuNi8rlFNaZrrypczOtu
	jaB3QeKLqENRXs1nVMHz4bx9oS5azpk8bbYn/X+F0JIJSkvy9MfY8pps/s2h1vUEFim2HKquXv7
	KqAoHbx/LSSg6coygKmK/HJ0D2vyq9Tei6a6NPLnx
X-Gm-Gg: AZuq6aImfza7TaRytHJgYSkX2ikAXsm/WyOhBtEDLZXGQ3ZGsI02spTRlDtwtcAbXMo
	lchCwe5/GDH9TRfHQzgkfVmMsdHLVMxtkGhblV0S5krmI0LcrkGOu6mZezIVEua3In6kbG0y71h
	L1rNmA7smLg4XcK7ZFyp66gAfVQTPUhCiHU5jVO9oaxGdTeO/LhdCIpyHt2mUNGjy5SJpOoX5M/
	thswZIfKO03TdY7QXe42pMUh+uMEBHUOmbt5IvvTS9USvcJ/MRUnHaMmibLp20XRioIQcQvHXi/
	bQI=
X-Received: by 2002:a17:90b:3b8a:b0:335:2823:3683 with SMTP id
 98e67ed59e1d1-3543b2fbda0mr3441568a91.9.1769789154162; Fri, 30 Jan 2026
 08:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130134220.305757-1-p@1g4.org>
In-Reply-To: <20260130134220.305757-1-p@1g4.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 30 Jan 2026 11:05:43 -0500
X-Gm-Features: AZwV_QjDngoIYar1a9pR5LAAkzFxuVZSfOhxk3xHVuv5DzUlcanElVS2Kqsrro8
Message-ID: <CAM0EoMkS2Uoarr+551wNe7zvmPTGFZxdb-otKYLBPF5+2s+FEg@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: act_api: size RTM_GETACTION reply by fill size
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255178-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2CE74BC60E
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 8:43=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> tcf_action_fill_size() already computes the required dump size, but
> RTM_GETACTION replies always allocate NLMSG_GOODSIZE. Large action
> state can overrun that skb and make dumps fail.
>
> Use the computed reply size for RTM_GETACTION replies so large actions
> can be dumped, while still keeping NLMSG_GOODSIZE as a floor.
>
> Fixes: 4e76e75d6aba ("net sched actions: calculate add/delete event messa=
ge size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---
>  net/sched/act_api.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/sched/act_api.c b/net/sched/act_api.c
> index e1ab0faeb8113..8ab016d352850 100644
> --- a/net/sched/act_api.c
> +++ b/net/sched/act_api.c
> @@ -1685,12 +1685,12 @@ static int tca_get_fill(struct sk_buff *skb, stru=
ct tc_action *actions[],
>
>  static int
>  tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
> -              struct tc_action *actions[], int event,
> +              struct tc_action *actions[], int event, size_t attr_size,
>                struct netlink_ext_ack *extack)
>  {
>         struct sk_buff *skb;
>
> -       skb =3D alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
> +       skb =3D alloc_skb(max_t(size_t, attr_size, NLMSG_GOODSIZE), GFP_K=
ERNEL);
>         if (!skb)
>                 return -ENOBUFS;
>         if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
> @@ -2041,7 +2041,8 @@ tca_action_gd(struct net *net, struct nlattr *nla, =
struct nlmsghdr *n,
>         attr_size =3D tcf_action_full_attrs_size(attr_size);
>
>         if (event =3D=3D RTM_GETACTION)
> -               ret =3D tcf_get_notify(net, portid, n, actions, event, ex=
tack);
> +               ret =3D tcf_get_notify(net, portid, n, actions, event,
> +                                    attr_size, extack);
>         else { /* delete */
>                 ret =3D tcf_del_notify(net, n, actions, portid, attr_size=
, extack);
>                 if (ret)

dunno. Is this based on some issue you found? This is a common pattern
in a lot of places in the stack and has not caused any issues (afaik).

cheers,
jamal

