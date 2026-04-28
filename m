Return-Path: <netdev+bounces-281876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ6VOoHH8GkqYgEAu9opvQ
	(envelope-from <netdev+bounces-281876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:43:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A45487332
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C71430C75E6
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77B946AECC;
	Tue, 28 Apr 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTkiwkQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F5466B6D
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382091; cv=pass; b=M5wHAsNxzPo/9o7+7XvF1lTIMelPvc+tCq5hMg/FF532ZycsCFRJqdwYdBrPehBmo/rUVhRUS1MvDcFt3QvwfN1lrct1XRW3dIvQR/rzvY/Lf51zuPpCCh5GP3v5OV3KD6LfPw2lEFwLJGg0xjDZeXbCP+0PFljto0xS6GQ9OEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382091; c=relaxed/simple;
	bh=ZwNPsWGyUBWsbKRpWETRmRdi5e9LTVhqmMjD+c8WfRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJrpklbvJ6OicHs8FLBRmzDUT0JjoedrOGthBQxSGmuXMWpjgKRyZ3jfZICq/nxs9mIyHAwJILCM67uE/UVKnaOPPINxjuscbA7GU7FXhaFQtyiwb/G+VokxHtOiNaBgUKfvrviJeJtMKwYTySwUD1tDg8FXfhpdFRYf9811sRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTkiwkQM; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e614fdb42so90208861cf.3
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777382089; cv=none;
        d=google.com; s=arc-20240605;
        b=javZw0UIiDN3CAwc707mFiRinyybkbBQFxaJdw6HtdWb2xRUZ3GTtKhaZGZghMMbnC
         p4NpQv/+utj0Jf62/BtIOpnVKgcUjD8bkHjWJR8QdvYxCCnREVeDOp9fJhl7XiKyV11n
         vUEVbLPMlFTAiL8D4K4ynAzjst/F38wlgEZh/Zqj05w2dEq+lRSl8vj8kqausN0D+If/
         98Il96ezAJMOMxn+dGKcZk8PwVZSZnXqtqp/BRbYWV+K8/9ldtVcxBdcM1ASPV/PUchb
         h3uNZaCiZJ2vvsUlg6ZMR8ZjDcfg59KWeRR9FXP/yUA0TmG+HBEeNYbfQL5ElesARzRV
         CmIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YSq9/1cMNyAq7AS9BzXp6MAhePxCxapDKbYhRtlzxjs=;
        fh=We58ljgs20Tw4fhTmZLMDU27g6aRAlHw/PmVlsA9kW4=;
        b=bb2dU2rOblZn/0gSPYhDxrp/T4AS1jrqo4rUif4Z+ETtpyUzvEToL/UrEKRjP6VSaX
         8WGoD7xjBG53HwWoJ/LTfr6CnJPp6IPhLqvfuuTlvO8XNM/cjqJcOL07cb0PSfvQd7QQ
         PSKh/qr6ueE6EZN89pnSYhU5E32xLzzwabOXWgGgpexvmcaUUCWuNbpSWe6oemc0JqHd
         K3ZOgulJlzwkH6kAS9Pr/VX/5g+TcFU1akXQGqk93vUjOpmHIhbjB6bLYeBSjofjAHtl
         KJbLkrIf4jVuptr9BEEzZT3asGZfaqdaIkf/DfV3N//SJ0bcTLd7DRfNxH3LPy/zqXxL
         QaRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777382089; x=1777986889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSq9/1cMNyAq7AS9BzXp6MAhePxCxapDKbYhRtlzxjs=;
        b=qTkiwkQMLhrU/ZIBMw3JCpz6+4SuvK92QBkMAOu7DLslunmr0McXwC6zZHctPVKHLF
         rzBfc0LzMEcmcoTTxykHY7Y6+RO7/0Z05pCczpFeKSc3lp0vIMcqy6THurHFQbd0kPur
         mLjdRuObodtWdGPap7kM98N6xbtPkJ+3k7AVOY5X03CFoSgJbET5C+NPG/ySdzo5T4bE
         qjp1YdVr3oCopNmvFOuwHmiBxGFyxpgfTebngM5Kgza7/GuD5sG3pJPL5vm9tEaqcbIb
         hge1q7+0U9wPNP86Eb7jJO748jVz3yQbhrBri4nN2hFPXRBc1W8fGW4c+eDTSYQJc7o5
         8rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382089; x=1777986889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSq9/1cMNyAq7AS9BzXp6MAhePxCxapDKbYhRtlzxjs=;
        b=cFYJ1r4t0HugPcPxbmGVPTK1jBGDdC69a8+5o25Ofu4b5LcYAUVC6rDVqgF7uYUAEP
         h6dx3M60lAzsSRC+uzKPKiD4PpOoNwc7oTFRNIAMGpVVZ9MvvMdtjTEqu0LezBWermbg
         zjLQcvqLUSTI6ALvTJfWgSyD2wqs6QAcUawogARmQVHtnttU2neYF8Ge8u1F+leEBRXJ
         8iwMTGZboWNIspUdcXcPOLJ8VhWYXryL6c0fzqPGNap6xMBYk9RJdqfS5M+anVS0Syan
         xxWkJpxKfWcUzRmZkTXRUy2WIU2Jx6QH33wntDs1NNy1Y6+PPhzL3vj0MWQf7Z+4FrFJ
         8aIA==
X-Gm-Message-State: AOJu0Yw3serGUCChcQIkFk4PrDhChuEPaXQKlSKqSOdxlW68N95WnYSj
	Wn0DZsIDTAMXZJj6xpJOZXZXKy/Wg/2axuw0PpvWHXp/yms8kFKeXhB212HmM8D3OseR4+V3EOO
	2BB1krwwQPRi+XD6HxBB/4aioxVIp1B3vI2PQzmslzzlj5hamu3I9K5O6
X-Gm-Gg: AeBDieukqFtbyHn2ukAFS1HtKkwIjpqyZXOZVrmfgf7PrYmvA6qmug+zcdeRMV6Z+WC
	lOxFpOYzKqX8SWd5hDoGkTT2L2IIY/l/xKS9jXDQ1E84QwSGSAnhHcs/GJvo2y0p2ZSmNDqdhP+
	7rTWB4iIBcmD+s399nuzQ0/ASi3rOQ12DX1vwaHUCo/jDAjaB3rrPFbeuE1uoYu5rlyQPz/awVw
	uK11OrCNdqGAsn8wuRelUj5zbnYHmQnYJvLh5TPo6FGQXc471SZ3jheoEpX6ma3clXgUy4NUtPd
	bJs9GuiApjiByq9d2WNisOBlDsQtKXifKnC+XSRuWj/X/HcwSV7yNpyOidTJ0lkWODN8N6zQ7xl
	i127MMDRg
X-Received: by 2002:a05:622a:1989:b0:50d:9174:cf33 with SMTP id
 d75a77b69052e-5100e123fbamr39330151cf.16.1777382087958; Tue, 28 Apr 2026
 06:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110713.2550315-1-maoyixie.tju@gmail.com> <20260428110713.2550315-3-maoyixie.tju@gmail.com>
In-Reply-To: <20260428110713.2550315-3-maoyixie.tju@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Apr 2026 06:14:36 -0700
X-Gm-Features: AVHnY4LLxwEILt1TTGPsaaRHkW5N_u-1e6yJrI0k1snh5_u9WCEuAoViwZNd9hE
Message-ID: <CANn89iJNXDk6cSeinqfsv+GWFhTV_c02-MwokTAtkEf7tgJntw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ip6_gre: Use cached t->net in ip6erspan_changelink().
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com, shaw.leon@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E7A45487332
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,gmail.com,davemloft.net,kernel.org,redhat.com,ms2.inr.ac.ru];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,ntu.edu.sg:email]

On Tue, Apr 28, 2026 at 4:07=E2=80=AFAM Maoyi Xie <maoyixie.tju@gmail.com> =
wrote:
>
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
>
> After commit 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of
> rtnl_link_ops"), ip6erspan_newlink() correctly resolves the per-netns
> ip6gre hash via link_net. ip6erspan_changelink() was not converted in
> that series and still uses dev_net(dev), which diverges from the
> device's creation netns after IFLA_NET_NS_FD migration.
>
> This re-inserts the tunnel into the wrong per-netns hash, leaving a
> stale entry in the original creation netns. When that netns is later
> destroyed, ip6gre_exit_rtnl_net() walks the stale entry, producing a
> slab-use-after-free reported by KASAN, followed by a kernel BUG at
> net/core/dev.c (LIST_POISON1) in unregister_netdevice_many_notify().
>
> Reachable from an unprivileged user namespace ("unshare --user
> --map-root-user --net"); cross-tenant scope on container hosts.
>
> Note: ip6gre_changelink() (the non-erspan sibling earlier in the same
> file) already uses the cached t->net correctly. The bug is specific
> to ip6erspan_changelink() copying the wrong shape.
>
> Fixes: 5e72ce3e3980 ("net: ipv6: Use link netns in newlink() of rtnl_link=
_ops")
> Reported-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> Cc: stable@vger.kernel.org # v5.15+
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
>  net/ipv6/ip6_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
> index dafcc0dcd..38ac14cc0 100644
> --- a/net/ipv6/ip6_gre.c
> +++ b/net/ipv6/ip6_gre.c
> @@ -2261,7 +2261,8 @@ static int ip6erspan_changelink(struct net_device *=
dev, struct nlattr *tb[],
>                                 struct nlattr *data[],
>                                 struct netlink_ext_ack *extack)
>  {
> -       struct ip6gre_net *ign =3D net_generic(dev_net(dev), ip6gre_net_i=
d);
> +       struct ip6_tnl *nt =3D netdev_priv(dev);
> +       struct ip6gre_net *ign =3D net_generic(nt->net, ip6gre_net_id);
>         struct __ip6_tnl_parm p;
>         struct ip6_tnl *t;
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

