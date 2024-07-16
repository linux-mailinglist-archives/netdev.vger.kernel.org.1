Return-Path: <netdev+bounces-111764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98969327B3
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 15:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477002844D9
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 13:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E5219ADAA;
	Tue, 16 Jul 2024 13:41:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45401199EA8
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137287; cv=none; b=QUUSASbTikuT+G99fm5jBuCxHrdTYnFO6FPvhE4VKjefq3hLNgOI28CVIvJonnPL/my7iJu28ro4sieK+6pBQVPKMR088PXP53pzsVHfGY+/u4uWQzvZvhXiHgObrMYxZ9vh6aiGYnNKbUgYhvW9LAxMz4QJYYleDPxS5mgwmE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137287; c=relaxed/simple;
	bh=AvHoWQi9qr14fSJtmeo4UJcZA5SifzsKpB9lsVsSeqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lyCo+Q7UyhgqsyPPCgjqZMvfgBubIb8t6vFcJcCyFxoHj8L0yJHsWlh/RQuj1R7ARqdxVm2hc0ePdBKuMCq+sCWOdI+0q4UNamvYXd7oxU0Sebcq55HYT/61Ad9kNhCyn1838jYUUt+WrBXD2WHsKvLTOACrQNoHjqyH34ByHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-500-cxRMfZVUORyKxqsbMssetA-1; Tue,
 16 Jul 2024 09:41:12 -0400
X-MC-Unique: cxRMfZVUORyKxqsbMssetA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDC141955D4E;
	Tue, 16 Jul 2024 13:41:10 +0000 (UTC)
Received: from hog (unknown [10.39.192.3])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C5251955F68;
	Tue, 16 Jul 2024 13:41:07 +0000 (UTC)
Date: Tue, 16 Jul 2024 15:41:04 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
	pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
Subject: Re: [PATCH net-next v5 20/25] ovpn: implement peer add/dump/delete
 via netlink
Message-ID: <ZpZ4cF7hLTIxBiej@hog>
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-21-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240627130843.21042-21-antonio@openvpn.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-06-27, 15:08:38 +0200, Antonio Quartulli wrote:
> @@ -29,7 +34,7 @@ MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
>   * Return: the netdevice, if found, or an error otherwise
>   */
>  static struct net_device *
> -ovpn_get_dev_from_attrs(struct net *net, struct genl_info *info)
> +ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info)

nit: this should be squashed into "add basic netlink support"


[...]
>  int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> -=09return -EOPNOTSUPP;
> +=09bool keepalive_set =3D false, new_peer =3D false;
> +=09struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
> +=09struct ovpn_struct *ovpn =3D info->user_ptr[0];
> +=09struct sockaddr_storage *ss =3D NULL;
> +=09u32 sockfd, id, interv, timeout;
> +=09struct socket *sock =3D NULL;
> +=09struct sockaddr_in mapped;
> +=09struct sockaddr_in6 *in6;
> +=09struct ovpn_peer *peer;
> +=09u8 *local_ip =3D NULL;
> +=09size_t sa_len;
> +=09int ret;
> +
> +=09if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
> +=09=09return -EINVAL;
> +
> +=09ret =3D nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_P=
EER],
> +=09=09=09       ovpn_peer_nl_policy, info->extack);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
> +=09=09=09      OVPN_A_PEER_ID))
> +=09=09return -EINVAL;
> +
> +=09id =3D nla_get_u32(attrs[OVPN_A_PEER_ID]);
> +=09/* check if the peer exists first, otherwise create a new one */
> +=09peer =3D ovpn_peer_get_by_id(ovpn, id);
> +=09if (!peer) {
> +=09=09peer =3D ovpn_peer_new(ovpn, id);
> +=09=09new_peer =3D true;
> +=09=09if (IS_ERR(peer)) {
> +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09=09       "cannot create new peer object for peer %u (sockad=
dr=3D%pIScp): %ld",
> +=09=09=09=09=09       id, ss, PTR_ERR(peer));

ss hasn't been set yet at this point, including it in the extack
message is not useful.

> +=09=09=09return PTR_ERR(peer);
> +=09=09}
> +=09}
> +
> +=09if (new_peer && NL_REQ_ATTR_CHECK(info->extack,
> +=09=09=09=09=09  info->attrs[OVPN_A_PEER], attrs,
> +=09=09=09=09=09  OVPN_A_PEER_SOCKET)) {

This can be checked at the start of the previous block (!peer), we'd
avoid a pointless peer allocation.

(and the linebreaks in NL_REQ_ATTR_CHECK end up being slightly better
because you don't need the "new_peer &&" test that is wider than the
tab used to indent the !peer block :))

> +=09=09ret =3D -EINVAL;
> +=09=09goto peer_release;
> +=09}
> +
> +=09if (new_peer && ovpn->mode =3D=3D OVPN_MODE_MP &&
> +=09    !attrs[OVPN_A_PEER_VPN_IPV4] && !attrs[OVPN_A_PEER_VPN_IPV6]) {

Same for this check.

> +=09=09NL_SET_ERR_MSG_MOD(info->extack,
> +=09=09=09=09   "a VPN IP is required when adding a peer in MP mode");
> +=09=09ret =3D -EINVAL;
> +=09=09goto peer_release;
> +=09}
> +
> +=09if (attrs[OVPN_A_PEER_SOCKET]) {
> +=09=09/* lookup the fd in the kernel table and extract the socket
> +=09=09 * object
> +=09=09 */
> +=09=09sockfd =3D nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
> +=09=09/* sockfd_lookup() increases sock's refcounter */
> +=09=09sock =3D sockfd_lookup(sockfd, &ret);
> +=09=09if (!sock) {
> +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09=09       "cannot lookup peer socket (fd=3D%u): %d",
> +=09=09=09=09=09       sockfd, ret);
> +=09=09=09ret =3D -ENOTSOCK;
> +=09=09=09goto peer_release;
> +=09=09}
> +
> +=09=09if (peer->sock)
> +=09=09=09ovpn_socket_put(peer->sock);
> +
> +=09=09peer->sock =3D ovpn_socket_new(sock, peer);
> +=09=09if (IS_ERR(peer->sock)) {
> +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09=09       "cannot encapsulate socket: %ld",
> +=09=09=09=09=09       PTR_ERR(peer->sock));
> +=09=09=09sockfd_put(sock);
> +=09=09=09peer->sock =3D NULL;

Is there any value for the client in keeping the old peer->sock
assigned if we fail here?

ie something like:

    tmp =3D ovpn_socket_new(sock, peer);
    if (IS_ERR(tmp)) {
        ...
        goto peer_release;
    }
    if (peer->sock)
        ovpn_socket_put(peer->sock);
    peer->sock =3D tmp;


But if it's just going to get rid of the old socket and the whole
association/peer on failure, probably not.

> +=09=09=09ret =3D -ENOTSOCK;
> +=09=09=09goto peer_release;
> +=09=09}
> +=09}
> +
> +=09/* Only when using UDP as transport protocol the remote endpoint
> +=09 * can be configured so that ovpn knows where to send packets
> +=09 * to.
> +=09 *
> +=09 * In case of TCP, the socket is connected to the peer and ovpn
> +=09 * will just send bytes over it, without the need to specify a
> +=09 * destination.

(that should also work with UDP "connected" sockets)


> +=09 */
> +=09if (peer->sock->sock->sk->sk_protocol =3D=3D IPPROTO_UDP &&
> +=09    attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
[...]
> +
> +=09=09if (attrs[OVPN_A_PEER_LOCAL_IP]) {
> +=09=09=09local_ip =3D ovpn_nl_attr_local_ip(info, ovpn,
> +=09=09=09=09=09=09=09 attrs,
> +=09=09=09=09=09=09=09 ss->ss_family);
> +=09=09=09if (IS_ERR(local_ip)) {
> +=09=09=09=09ret =3D PTR_ERR(local_ip);
> +=09=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09=09=09       "cannot retrieve local IP: %d",
> +=09=09=09=09=09=09       ret);

ovpn_nl_attr_local_ip already sets a more specific extack message,
this is unnecessary.

> +=09=09=09=09goto peer_release;
> +=09=09=09}
> +=09=09}
> +
> +=09=09/* set peer sockaddr */
> +=09=09ret =3D ovpn_peer_reset_sockaddr(peer, ss, local_ip);
> +=09=09if (ret < 0) {
> +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09=09       "cannot set peer sockaddr: %d",
> +=09=09=09=09=09       ret);
> +=09=09=09goto peer_release;
> +=09=09}
> +=09}

I would reject OVPN_A_PEER_SOCKADDR_REMOTE for a non-UDP socket.


> +=09/* VPN IPs cannot be updated, because they are hashed */

Then I think there should be something like

    if (!new_peer && (attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_=
IPV6])) {
        NL_SET_ERR_MSG_FMT_MOD(... "can't update ip");
        ret =3D -EINVAL;
        goto peer_release;
    }

(just after getting the peer, before any changes have actually been
made)

And if they are only used in MP mode, I would maybe also reject
requests where mode=3D=3DP2P and OVPN_A_PEER_VPN_IPV* is provided.


> +=09if (new_peer && attrs[OVPN_A_PEER_VPN_IPV4])
> +=09=09peer->vpn_addrs.ipv4.s_addr =3D
> +=09=09=09nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
> +
> +=09/* VPN IPs cannot be updated, because they are hashed */
> +=09if (new_peer && attrs[OVPN_A_PEER_VPN_IPV6])
> +=09=09peer->vpn_addrs.ipv6 =3D
> +=09=09=09nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
> +
> +=09/* when setting the keepalive, both parameters have to be configured =
*/

Then I would also reject a config where only one is set (also before any
changes have been made).

> +=09if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
> +=09    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
> +=09=09keepalive_set =3D true;
> +=09=09interv =3D nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
> +=09=09timeout =3D nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
> +=09}
> +
> +=09if (keepalive_set)
> +=09=09ovpn_peer_keepalive_set(peer, interv, timeout);

Why not skip the bool and just do this in the previous block?

> +=09netdev_dbg(ovpn->dev,
> +=09=09   "%s: %s peer with endpoint=3D%pIScp/%s id=3D%u VPN-IPv4=3D%pI4 =
VPN-IPv6=3D%pI6c\n",
> +=09=09   __func__, (new_peer ? "adding" : "modifying"), ss,
> +=09=09   peer->sock->sock->sk->sk_prot_creator->name, peer->id,
> +=09=09   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
> +
> +=09if (new_peer) {
> +=09=09ret =3D ovpn_peer_add(ovpn, peer);
> +=09=09if (ret < 0) {
> +=09=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09=09       "cannot add new peer (id=3D%u) to hashtable: %d\n"=
,
> +=09=09=09=09=09       peer->id, ret);
> +=09=09=09goto peer_release;
> +=09=09}
> +=09} else {
> +=09=09ovpn_peer_put(peer);
> +=09}
> +
> +=09return 0;
> +
> +peer_release:
> +=09if (new_peer) {
> +=09=09/* release right away because peer is not really used in any
> +=09=09 * context
> +=09=09 */
> +=09=09ovpn_peer_release(peer);
> +=09=09kfree(peer);

I don't think that's correct, the new peer was created with
ovpn_peer_new, so it took a reference on the netdevice
(netdev_hold(ovpn->dev, ...)), which isn't released by
ovpn_peer_release. Why not just go through ovpn_peer_put?

> +=09} else {
> +=09=09ovpn_peer_put(peer);
> +=09}
> +
> +=09return ret;
> +}
> +

[...]
>  int ovpn_nl_get_peer_doit(struct sk_buff *skb, struct genl_info *info)
>  {
[...]
> +=09peer_id =3D nla_get_u32(attrs[OVPN_A_PEER_ID]);
> +=09peer =3D ovpn_peer_get_by_id(ovpn, peer_id);
> +=09if (!peer) {
> +=09=09NL_SET_ERR_MSG_FMT_MOD(info->extack,
> +=09=09=09=09       "cannot find peer with id %u", peer_id);
> +=09=09return -ENOENT;
> +=09}
> +
> +=09msg =3D nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +=09if (!msg)

Missing ovpn_peer_put?

> +=09=09return -ENOMEM;
> +
> +=09ret =3D ovpn_nl_send_peer(msg, info, peer, info->snd_portid,
> +=09=09=09=09info->snd_seq, 0);
> +=09if (ret < 0) {
> +=09=09nlmsg_free(msg);
> +=09=09goto err;
> +=09}
> +
> +=09ret =3D genlmsg_reply(msg, info);
> +err:
> +=09ovpn_peer_put(peer);
> +=09return ret;
>  }

--=20
Sabrina


