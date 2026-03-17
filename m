Return-Path: <netdev+bounces-268686-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBYfKKeDuWlyIgIAu9opvQ
	(envelope-from <netdev+bounces-268686-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:39:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052622AE267
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CACC300228C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983FB3E9F93;
	Tue, 17 Mar 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b="AnwmwD+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A813A641D
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765249; cv=none; b=GODbCS+zrW3nGqFgwDCYdqnU9nzjdM+dFtDwtBf/2hKMYbu0AypUjn72CIhaSA6Y1WgYjown9nvA7emzHRX3vyhPgb9fIRYKVyCemE0KpN3x4uflyylB9cDECo1Swb4kPMqAJZMWKYPupInmWYEZMIQJ302sNkPx7R8Xo+O/KfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765249; c=relaxed/simple;
	bh=bMlcgdHPZBysdMnkKkz3QhQ0huoij54AJPW3JxtOnz8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VkeTYY9h0Ddq227tMLQlNObM4vSh2Tr/7wpB/HLggmHA4q90wGY2B6r6cHBOqyXZ/PztEd103n/JUGShzuUWxzKxykieMxO0umAcmRXu1X/Iqn9n2vmQvcvcZOAwypwNlawiopbXIdojVjYbGXEXZ2jXot7uUvbaQ5Qc7qPaalk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org; spf=pass smtp.mailfrom=1g4.org; dkim=pass (2048-bit key) header.d=1g4.org header.i=@1g4.org header.b=AnwmwD+s; arc=none smtp.client-ip=185.70.43.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1g4.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
	s=protonmail2; t=1773765241; x=1774024441;
	bh=D83ix0D3DP0XDOLD1upCmz5Ezr3pqIjkYNNYxQfMuBA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=AnwmwD+sIaJtjKw65YdSjMwdGGmGR+aOUtxJO17MYQJodD7jQhvpaDq47Rt481lD1
	 /0+lqi/bvjHWARhHnjF5Bkl7YcZWuAfMl91gEXmRE+RSeChy6aKJDSNf5MYrkPcclm
	 76SgKSAw0U1uqTQS4n/Yj8Tgq1mxa9nn++PekUEKcB+/r/gY1F+P2BGUi9/cIRL2td
	 cif8ozBxXlBM6vz8ofH0lVAkxrPxTjVTUu9ZnLJXj34zrhNewqbZsMYd41Bah/mATb
	 Oq3LSQqHL61nG9XI7iFoKW5I4jFo1mspsiXpBAxHLeuemnrl9lsgHtYANXJ07PFCkP
	 Hp4/APucgAmXg==
Date: Tue, 17 Mar 2026 16:33:55 +0000
To: Jakub Kicinski <kuba@kernel.org>
From: Paul Moses <p@1g4.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com, chuck.lever@oracle.com, matttbe@kernel.org, ast@fiberby.net, jiri@resnulli.us
Subject: Re: [PATCH net 2/2] net: shaper: protect from late creation of hierarchy
Message-ID: <GqF0Y80pSgdSvmu5Ir9xbbrqafz2EjbxJ12ZPFV303X8BsVPvQ3k8PGyhpfO0cKg-DNYWgnDve0YPYi4lJ2of4An7dwRrJNCspDFHQK_f70=@1g4.org>
In-Reply-To: <20260317161014.779569-2-kuba@kernel.org>
References: <20260317161014.779569-1-kuba@kernel.org> <20260317161014.779569-2-kuba@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: dfe157e75364a292473e893afdf3c73f5307984c
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1g4.org,quarantine];
	R_DKIM_ALLOW(-0.20)[1g4.org:s=protonmail2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268686-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com,fiberby.net,resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[p@1g4.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[1g4.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,1g4.org:dkim,1g4.org:mid]
X-Rspamd-Queue-Id: 052622AE267
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Congrats, now tell everyone that I did close the memory safety
issue, you just added a cleanup. ;)



On Tuesday, March 17th, 2026 at 11:10 AM, Jakub Kicinski <kuba@kernel.org> =
wrote:

> We look up a netdev during prep of Netlink ops (pre- callbacks)
> and take a ref to it. Then later in the body of the callback
> we take its lock or RCU which are the actual protections.
>=20
> The netdev may get unregistered in between the time we take
> the ref and the time we lock it. We may allocate the hierarchy
> after flush has already run, which would lead to a leak.
>=20
> Take the instance lock in pre- already, this saves us from the race
> and removes the need for dedicated lock/unlock callbacks completely.
> After all, if there's any chance of write happening concurrently
> with the flush - we're back to leaking the hierarchy.
>=20
> We may take the lock for devices which don't support shapers but
> we're only dealing with SET operations here, not taking the lock
> would be optimizing for an error case.
>=20
> Fixes: 93954b40f6a4 ("net-shapers: implement NL set and delete operations=
")
> Link: https://lore.kernel.org/20260309173450.538026-1-p@1g4.org
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/net_shaper.yaml |  12 +-
>  net/shaper/shaper_nl_gen.h                  |   5 +
>  net/shaper/shaper.c                         | 134 +++++++++++---------
>  net/shaper/shaper_nl_gen.c                  |  12 +-
>  4 files changed, 89 insertions(+), 74 deletions(-)
>=20
> diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/=
netlink/specs/net_shaper.yaml
> index 0b1b54be48f9..3f2ad772b64b 100644
> --- a/Documentation/netlink/specs/net_shaper.yaml
> +++ b/Documentation/netlink/specs/net_shaper.yaml
> @@ -247,8 +247,8 @@ doc: |
>        flags: [admin-perm]
>=20
>        do:
> -        pre: net-shaper-nl-pre-doit
> -        post: net-shaper-nl-post-doit
> +        pre: net-shaper-nl-pre-doit-write
> +        post: net-shaper-nl-post-doit-write
>          request:
>            attributes:
>              - ifindex
> @@ -278,8 +278,8 @@ doc: |
>        flags: [admin-perm]
>=20
>        do:
> -        pre: net-shaper-nl-pre-doit
> -        post: net-shaper-nl-post-doit
> +        pre: net-shaper-nl-pre-doit-write
> +        post: net-shaper-nl-post-doit-write
>          request:
>            attributes: *ns-binding
>=20
> @@ -309,8 +309,8 @@ doc: |
>        flags: [admin-perm]
>=20
>        do:
> -        pre: net-shaper-nl-pre-doit
> -        post: net-shaper-nl-post-doit
> +        pre: net-shaper-nl-pre-doit-write
> +        post: net-shaper-nl-post-doit-write
>          request:
>            attributes:
>              - ifindex
> diff --git a/net/shaper/shaper_nl_gen.h b/net/shaper/shaper_nl_gen.h
> index ec41c90431a4..42c46c52c775 100644
> --- a/net/shaper/shaper_nl_gen.h
> +++ b/net/shaper/shaper_nl_gen.h
> @@ -18,12 +18,17 @@ extern const struct nla_policy net_shaper_leaf_info_n=
l_policy[NET_SHAPER_A_WEIGH
>=20
>  int net_shaper_nl_pre_doit(const struct genl_split_ops *ops,
>  =09=09=09   struct sk_buff *skb, struct genl_info *info);
> +int net_shaper_nl_pre_doit_write(const struct genl_split_ops *ops,
> +=09=09=09=09 struct sk_buff *skb, struct genl_info *info);
>  int net_shaper_nl_cap_pre_doit(const struct genl_split_ops *ops,
>  =09=09=09       struct sk_buff *skb, struct genl_info *info);
>  void
>  net_shaper_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff=
 *skb,
>  =09=09=09struct genl_info *info);
>  void
> +net_shaper_nl_post_doit_write(const struct genl_split_ops *ops,
> +=09=09=09      struct sk_buff *skb, struct genl_info *info);
> +void
>  net_shaper_nl_cap_post_doit(const struct genl_split_ops *ops,
>  =09=09=09    struct sk_buff *skb, struct genl_info *info);
>  int net_shaper_nl_pre_dumpit(struct netlink_callback *cb);
> diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
> index 6b4c87e12f1f..94bc9c7382ea 100644
> --- a/net/shaper/shaper.c
> +++ b/net/shaper/shaper.c
> @@ -36,24 +36,6 @@ static struct net_shaper_binding *net_shaper_binding_f=
rom_ctx(void *ctx)
>  =09return &((struct net_shaper_nl_ctx *)ctx)->binding;
>  }
>=20
> -static void net_shaper_lock(struct net_shaper_binding *binding)
> -{
> -=09switch (binding->type) {
> -=09case NET_SHAPER_BINDING_TYPE_NETDEV:
> -=09=09netdev_lock(binding->netdev);
> -=09=09break;
> -=09}
> -}
> -
> -static void net_shaper_unlock(struct net_shaper_binding *binding)
> -{
> -=09switch (binding->type) {
> -=09case NET_SHAPER_BINDING_TYPE_NETDEV:
> -=09=09netdev_unlock(binding->netdev);
> -=09=09break;
> -=09}
> -}
> -
>  static struct net_shaper_hierarchy *
>  net_shaper_hierarchy(struct net_shaper_binding *binding)
>  {
> @@ -219,12 +201,49 @@ static int net_shaper_ctx_setup(const struct genl_i=
nfo *info, int type,
>  =09return 0;
>  }
>=20
> +/* Like net_shaper_ctx_setup(), but for "write" handlers (never for dump=
s!)
> + * Acquires the lock protecting the hierarchy (instance lock for netdev)=
.
> + */
> +static int net_shaper_ctx_setup_lock(const struct genl_info *info, int t=
ype,
> +=09=09=09=09     struct net_shaper_nl_ctx *ctx)
> +{
> +=09struct net *ns =3D genl_info_net(info);
> +=09struct net_device *dev;
> +=09int ifindex;
> +
> +=09if (GENL_REQ_ATTR_CHECK(info, type))
> +=09=09return -EINVAL;
> +
> +=09ifindex =3D nla_get_u32(info->attrs[type]);
> +=09dev =3D netdev_get_by_index_lock(ns, ifindex);
> +=09if (!dev) {
> +=09=09NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
> +=09=09return -ENOENT;
> +=09}
> +
> +=09if (!dev->netdev_ops->net_shaper_ops) {
> +=09=09NL_SET_BAD_ATTR(info->extack, info->attrs[type]);
> +=09=09netdev_unlock(dev);
> +=09=09return -EOPNOTSUPP;
> +=09}
> +
> +=09ctx->binding.type =3D NET_SHAPER_BINDING_TYPE_NETDEV;
> +=09ctx->binding.netdev =3D dev;
> +=09return 0;
> +}
> +
>  static void net_shaper_ctx_cleanup(struct net_shaper_nl_ctx *ctx)
>  {
>  =09if (ctx->binding.type =3D=3D NET_SHAPER_BINDING_TYPE_NETDEV)
>  =09=09netdev_put(ctx->binding.netdev, &ctx->dev_tracker);
>  }
>=20
> +static void net_shaper_ctx_cleanup_unlock(struct net_shaper_nl_ctx *ctx)
> +{
> +=09if (ctx->binding.type =3D=3D NET_SHAPER_BINDING_TYPE_NETDEV)
> +=09=09netdev_unlock(ctx->binding.netdev);
> +}
> +
>  static u32 net_shaper_handle_to_index(const struct net_shaper_handle *ha=
ndle)
>  {
>  =09return FIELD_PREP(NET_SHAPER_SCOPE_MASK, handle->scope) |
> @@ -278,7 +297,7 @@ net_shaper_lookup(struct net_shaper_binding *binding,
>  }
>=20
>  /* Allocate on demand the per device shaper's hierarchy container.
> - * Called under the net shaper lock
> + * Called under the lock protecting the hierarchy (instance lock for net=
dev)
>   */
>  static struct net_shaper_hierarchy *
>  net_shaper_hierarchy_setup(struct net_shaper_binding *binding)
> @@ -697,6 +716,22 @@ void net_shaper_nl_post_doit(const struct genl_split=
_ops *ops,
>  =09net_shaper_generic_post(info);
>  }
>=20
> +int net_shaper_nl_pre_doit_write(const struct genl_split_ops *ops,
> +=09=09=09=09struct sk_buff *skb, struct genl_info *info)
> +{
> +=09struct net_shaper_nl_ctx *ctx =3D (struct net_shaper_nl_ctx *)info->c=
tx;
> +
> +=09BUILD_BUG_ON(sizeof(*ctx) > sizeof(info->ctx));
> +
> +=09return net_shaper_ctx_setup_lock(info, NET_SHAPER_A_IFINDEX, ctx);
> +}
> +
> +void net_shaper_nl_post_doit_write(const struct genl_split_ops *ops,
> +=09=09=09=09   struct sk_buff *skb, struct genl_info *info)
> +{
> +=09net_shaper_ctx_cleanup_unlock((struct net_shaper_nl_ctx *)info->ctx);
> +}
> +
>  int net_shaper_nl_pre_dumpit(struct netlink_callback *cb)
>  {
>  =09struct net_shaper_nl_ctx *ctx =3D (struct net_shaper_nl_ctx *)cb->ctx=
;
> @@ -824,45 +859,38 @@ int net_shaper_nl_set_doit(struct sk_buff *skb, str=
uct genl_info *info)
>=20
>  =09binding =3D net_shaper_binding_from_ctx(info->ctx);
>=20
> -=09net_shaper_lock(binding);
>  =09ret =3D net_shaper_parse_info(binding, info->attrs, info, &shaper,
>  =09=09=09=09    &exists);
>  =09if (ret)
> -=09=09goto unlock;
> +=09=09return ret;
>=20
>  =09if (!exists)
>  =09=09net_shaper_default_parent(&shaper.handle, &shaper.parent);
>=20
>  =09hierarchy =3D net_shaper_hierarchy_setup(binding);
> -=09if (!hierarchy) {
> -=09=09ret =3D -ENOMEM;
> -=09=09goto unlock;
> -=09}
> +=09if (!hierarchy)
> +=09=09return -ENOMEM;
>=20
>  =09/* The 'set' operation can't create node-scope shapers. */
>  =09handle =3D shaper.handle;
>  =09if (handle.scope =3D=3D NET_SHAPER_SCOPE_NODE &&
> -=09    !net_shaper_lookup(binding, &handle)) {
> -=09=09ret =3D -ENOENT;
> -=09=09goto unlock;
> -=09}
> +=09    !net_shaper_lookup(binding, &handle))
> +=09=09return -ENOENT;
>=20
>  =09ret =3D net_shaper_pre_insert(binding, &handle, info->extack);
>  =09if (ret)
> -=09=09goto unlock;
> +=09=09return ret;
>=20
>  =09ops =3D net_shaper_ops(binding);
>  =09ret =3D ops->set(binding, &shaper, info->extack);
>  =09if (ret) {
>  =09=09net_shaper_rollback(binding);
> -=09=09goto unlock;
> +=09=09return ret;
>  =09}
>=20
>  =09net_shaper_commit(binding, 1, &shaper);
>=20
> -unlock:
> -=09net_shaper_unlock(binding);
> -=09return ret;
> +=09return 0;
>  }
>=20
>  static int __net_shaper_delete(struct net_shaper_binding *binding,
> @@ -1090,35 +1118,26 @@ int net_shaper_nl_delete_doit(struct sk_buff *skb=
, struct genl_info *info)
>=20
>  =09binding =3D net_shaper_binding_from_ctx(info->ctx);
>=20
> -=09net_shaper_lock(binding);
>  =09ret =3D net_shaper_parse_handle(info->attrs[NET_SHAPER_A_HANDLE], inf=
o,
>  =09=09=09=09      &handle);
>  =09if (ret)
> -=09=09goto unlock;
> +=09=09return ret;
>=20
>  =09hierarchy =3D net_shaper_hierarchy(binding);
> -=09if (!hierarchy) {
> -=09=09ret =3D -ENOENT;
> -=09=09goto unlock;
> -=09}
> +=09if (!hierarchy)
> +=09=09return -ENOENT;
>=20
>  =09shaper =3D net_shaper_lookup(binding, &handle);
> -=09if (!shaper) {
> -=09=09ret =3D -ENOENT;
> -=09=09goto unlock;
> -=09}
> +=09if (!shaper)
> +=09=09return -ENOENT;
>=20
>  =09if (handle.scope =3D=3D NET_SHAPER_SCOPE_NODE) {
>  =09=09ret =3D net_shaper_pre_del_node(binding, shaper, info->extack);
>  =09=09if (ret)
> -=09=09=09goto unlock;
> +=09=09=09return ret;
>  =09}
>=20
> -=09ret =3D __net_shaper_delete(binding, shaper, info->extack);
> -
> -unlock:
> -=09net_shaper_unlock(binding);
> -=09return ret;
> +=09return __net_shaper_delete(binding, shaper, info->extack);
>  }
>=20
>  static int net_shaper_group_send_reply(struct net_shaper_binding *bindin=
g,
> @@ -1167,21 +1186,17 @@ int net_shaper_nl_group_doit(struct sk_buff *skb,=
 struct genl_info *info)
>  =09if (!net_shaper_ops(binding)->group)
>  =09=09return -EOPNOTSUPP;
>=20
> -=09net_shaper_lock(binding);
>  =09leaves_count =3D net_shaper_list_len(info, NET_SHAPER_A_LEAVES);
>  =09if (!leaves_count) {
>  =09=09NL_SET_BAD_ATTR(info->extack,
>  =09=09=09=09info->attrs[NET_SHAPER_A_LEAVES]);
> -=09=09ret =3D -EINVAL;
> -=09=09goto unlock;
> +=09=09return -EINVAL;
>  =09}
>=20
>  =09leaves =3D kcalloc(leaves_count, sizeof(struct net_shaper) +
>  =09=09=09 sizeof(struct net_shaper *), GFP_KERNEL);
> -=09if (!leaves) {
> -=09=09ret =3D -ENOMEM;
> -=09=09goto unlock;
> -=09}
> +=09if (!leaves)
> +=09=09return -ENOMEM;
>  =09old_nodes =3D (void *)&leaves[leaves_count];
>=20
>  =09ret =3D net_shaper_parse_node(binding, info->attrs, info, &node);
> @@ -1258,9 +1273,6 @@ int net_shaper_nl_group_doit(struct sk_buff *skb, s=
truct genl_info *info)
>=20
>  free_leaves:
>  =09kfree(leaves);
> -
> -unlock:
> -=09net_shaper_unlock(binding);
>  =09return ret;
>=20
>  free_msg:
> @@ -1370,14 +1382,12 @@ static void net_shaper_flush(struct net_shaper_bi=
nding *binding)
>  =09if (!hierarchy)
>  =09=09return;
>=20
> -=09net_shaper_lock(binding);
>  =09xa_lock(&hierarchy->shapers);
>  =09xa_for_each(&hierarchy->shapers, index, cur) {
>  =09=09__xa_erase(&hierarchy->shapers, index);
>  =09=09kfree(cur);
>  =09}
>  =09xa_unlock(&hierarchy->shapers);
> -=09net_shaper_unlock(binding);
>=20
>  =09kfree(hierarchy);
>  }
> diff --git a/net/shaper/shaper_nl_gen.c b/net/shaper/shaper_nl_gen.c
> index e8cccc4c1180..9b29be3ef19a 100644
> --- a/net/shaper/shaper_nl_gen.c
> +++ b/net/shaper/shaper_nl_gen.c
> @@ -99,27 +99,27 @@ static const struct genl_split_ops net_shaper_nl_ops[=
] =3D {
>  =09},
>  =09{
>  =09=09.cmd=09=09=3D NET_SHAPER_CMD_SET,
> -=09=09.pre_doit=09=3D net_shaper_nl_pre_doit,
> +=09=09.pre_doit=09=3D net_shaper_nl_pre_doit_write,
>  =09=09.doit=09=09=3D net_shaper_nl_set_doit,
> -=09=09.post_doit=09=3D net_shaper_nl_post_doit,
> +=09=09.post_doit=09=3D net_shaper_nl_post_doit_write,
>  =09=09.policy=09=09=3D net_shaper_set_nl_policy,
>  =09=09.maxattr=09=3D NET_SHAPER_A_IFINDEX,
>  =09=09.flags=09=09=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  =09},
>  =09{
>  =09=09.cmd=09=09=3D NET_SHAPER_CMD_DELETE,
> -=09=09.pre_doit=09=3D net_shaper_nl_pre_doit,
> +=09=09.pre_doit=09=3D net_shaper_nl_pre_doit_write,
>  =09=09.doit=09=09=3D net_shaper_nl_delete_doit,
> -=09=09.post_doit=09=3D net_shaper_nl_post_doit,
> +=09=09.post_doit=09=3D net_shaper_nl_post_doit_write,
>  =09=09.policy=09=09=3D net_shaper_delete_nl_policy,
>  =09=09.maxattr=09=3D NET_SHAPER_A_IFINDEX,
>  =09=09.flags=09=09=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>  =09},
>  =09{
>  =09=09.cmd=09=09=3D NET_SHAPER_CMD_GROUP,
> -=09=09.pre_doit=09=3D net_shaper_nl_pre_doit,
> +=09=09.pre_doit=09=3D net_shaper_nl_pre_doit_write,
>  =09=09.doit=09=09=3D net_shaper_nl_group_doit,
> -=09=09.post_doit=09=3D net_shaper_nl_post_doit,
> +=09=09.post_doit=09=3D net_shaper_nl_post_doit_write,
>  =09=09.policy=09=09=3D net_shaper_group_nl_policy,
>  =09=09.maxattr=09=3D NET_SHAPER_A_LEAVES,
>  =09=09.flags=09=09=3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> --
> 2.53.0
>=20
> 

