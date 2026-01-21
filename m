Return-Path: <netdev+bounces-251694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMpBAh0xcGkSXAAAu9opvQ
	(envelope-from <netdev+bounces-251694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:51:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5A24F5DE
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 327A458902E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4931ED80;
	Wed, 21 Jan 2026 01:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJnXrHkq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19004314D07;
	Wed, 21 Jan 2026 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768960279; cv=none; b=I5tR7a/zRSQSpDt/abgBkOjHSzcl4/JiDTaQVtpsEhC5lvf3JXGDR5TThMYxNdQmNOmyN5c6juTbg2xbWsha4AmSOWbxgDymIxF0JgpVMioLuHayUna19n+YOw0a4abEwv4il6eyjrWLCNDnxL0eINXrfhr3CKtCf6l43SnC1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768960279; c=relaxed/simple;
	bh=PB1H58Qq1yo/KEkWLRv6MeXZ/f+uBAcJMyU4xF+GYjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dy6MaXkrTikHkLC9pan2flIFnZBuFq+juFGo5zDTQy9W6c3oan06if0+9c7zbgE6J8yD2jk2pdOnjrJaEAKd9WIQh3ifU7NyJmR1M6b9xw2mQ8s4hpxQsbbw/lrgg9PF0pxteBO6lXKbcDjvS2xFZuIXDUJ0DdDPlSDoELvIVDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJnXrHkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D65C16AAE;
	Wed, 21 Jan 2026 01:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768960277;
	bh=PB1H58Qq1yo/KEkWLRv6MeXZ/f+uBAcJMyU4xF+GYjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJnXrHkqjwsosPA2uE2fv0k+yp8vJT4A8sL5wmrftuY670Teg9a05LYvcCKG4+HXy
	 FkwC7FVjIfTbfgjaCl0pePQf97x2FnCGXCdeFa3FKxTQED8gJB0ovcnRjcT6bNcUGy
	 PBLf4Tv6xso+Jc6e0hOtOgHAzg9G03fNeaXNRlOVMRL+jXOESRC81PBC4GfRQI3okU
	 4qiA31iRk+LjjCuz/xrjMDYkSWn03JHYQWrA+35N7jDZWNwtwX7oYHhm4I2siMNjNd
	 xHhZmxdp9RY/fye1ecriCjZrcLrcS1t4CLfNO1YQfYYXj7dsMVpNTnnla+8lb+7FDH
	 a84tX/rQImDjg==
Date: Tue, 20 Jan 2026 17:51:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 15/16] selftests/net: Make NetDrvContEnv
 support queue leasing
Message-ID: <20260120175115.12c9735f@kernel.org>
In-Reply-To: <20260115082603.219152-16-daniel@iogearbox.net>
References: <20260115082603.219152-1-daniel@iogearbox.net>
	<20260115082603.219152-16-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	TAGGED_FROM(0.00)[bounces-251694-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9C5A24F5DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 15 Jan 2026 09:26:02 +0100 Daniel Borkmann wrote:
> +    def _lease_queues(self):
> +        channels = self.ethnl.channels_get({'header': {'dev-index': self.ifindex}})
> +        channels = channels['combined-count']
> +        if channels < 2:
> +            raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
> +
> +        rings = self.ethnl.rings_get({'header': {'dev-index': self.ifindex}})
> +        self._rx_rings = rings['rx']
> +        self._hds_thresh = rings.get('hds-thresh', 0)
> +        self.ethnl.rings_set({'header': {'dev-index': self.ifindex},
> +                            'tcp-data-split': 'enabled',
> +                            'hds-thresh': 0,
> +                            'rx': 64})
> +        self.src_queue = channels - 1
> +        bind_result = self.netdevnl.queue_create(
> +            {
> +                "ifindex": self.nk_guest_ifindex,
> +                "type": "rx",
> +                "lease": {
> +                    "ifindex": self.ifindex,
> +                    "queue": {"id": self.src_queue, "type": "rx"},
> +                },
> +            }
> +        )
> +        self.nk_queue = bind_result['id']
> +        self._leased = True

No frameworks, please, this belongs in the test itself.

