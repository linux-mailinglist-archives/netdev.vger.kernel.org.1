Return-Path: <netdev+bounces-275696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFM6DIH402k4ogcAu9opvQ
	(envelope-from <netdev+bounces-275696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:16:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E08F3A61A0
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 20:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5279D3017027
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914A438F923;
	Mon,  6 Apr 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUaeIvOI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F18F38E5DA
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499257; cv=none; b=Ykwbu82g3FzOcFP4hGrMEA6csjzBmfX7UjkSvJCUvxTw9g6tLumE5FTyNI+toD6WrNX9ejx3sxfo8rsfVdaueG2A/dY6IghAZWA3aTFgWmLqDVpYSQm4c0ekH659BtI/lPdX2LFXCm3ACAwjVJzOkIRPkRCJXtzlxkUE9da0Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499257; c=relaxed/simple;
	bh=qUdOjEAMvmH7efMDC7D2HhPL8uzmdroQVyLsnXvG5Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpeYP9+RvtvmasknvgVz4b699G6Bq/NJzD8eTPX0lWQB0Hk4b02Ej8hSW5uE/3mvtw5XObwaHxa9K4Y8+IZTrFqFfqUiIduJ2scbeTnS7HHtm08D41x0KlAnMc8I+6KKM5vFfBaJlMcjBFQLXWMuggUZlpKLRmPWlzorh2bcjzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUaeIvOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5B0C4CEF7;
	Mon,  6 Apr 2026 18:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775499257;
	bh=qUdOjEAMvmH7efMDC7D2HhPL8uzmdroQVyLsnXvG5Wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cUaeIvOIJLaA5vnSQNHwTX0g8gt5UPDp+v0C43t+z4dA6LA5Rkc653SaaF3u7VSwr
	 ZMIVn+cwFnfBmtqBO6TKgi4Hl9YbWPsJswHmfFaIDFmw5QazcDisxbQxJGHI58CiSL
	 3o4ISsRq7WGvsR0whTuAi79XI3xUFFZFudjzczHNac8r2Q0ZrlWyDZTFznYNlR5nvG
	 +6TimnMd770JhbkULYHofa5xQzqZD3svYAF8UZ+CNY+USfLtOqm1uRnrUQrwHWvAGb
	 EyPu7ax68A3WRYC+3zuPdqgw/LnrsUFBlPKlMel5oQNVcgAlHqrW/0UkyLnzdmjLwi
	 87IqbeebjYDAQ==
Message-ID: <b6cc7bc1-f18b-43d2-a21a-c964466fa882@kernel.org>
Date: Mon, 6 Apr 2026 12:14:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: l3mdev: Ignore non-L3 uppers in
 l3mdev_fib_table_rcu
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, Ao Zhou <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@resnulli.us>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>
References: <cover.1775062214.git.royenheart@gmail.com>
 <429dd4a81d4ca5624ab9f6d7b53c5fe08552c734.1775443332.git.royenheart@gmail.com>
 <20260406154808.GA714138@shredder>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260406154808.GA714138@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275696-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,resnulli.us,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8E08F3A61A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/6/26 9:48 AM, Ido Schimmel wrote:
> 
> Don't we have the same problem in l3mdev_l3_rcv() and l3mdev_l3_out()?
> If so, please check if I missed more places and include them in v3.
> 
> And I think that the part that I was missing earlier is that we don't
> have RCU synchronization in the unslaving path, so an RCU reader can
> either see the original master, NULL or a new master (e.g., bridge
> instead of the original VRF master).

synchronize_rcu after the unlink (control path) seems like a better,
more robust option than adding more checks to the datapath.

