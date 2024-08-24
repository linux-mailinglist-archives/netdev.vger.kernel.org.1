Return-Path: <netdev+bounces-121662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67B95DF3A
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 19:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F08F1C20F22
	for <lists+netdev@lfdr.de>; Sat, 24 Aug 2024 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E6664C6;
	Sat, 24 Aug 2024 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5/fjCIC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4AA39AEB;
	Sat, 24 Aug 2024 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724521078; cv=none; b=Kc+ChygKDYy6D8aUk2rHelOusLslQT1eE1SVEZ8FlWmd6XtStGO1/1uJWQWG4i/Zp3eSD+MIn/8z42DsETYenSQwg+wXG6J+/IDcDYtmgD7DA/0LLx4oqqDbI7WGSRT+u0FoU8Mfx2n8hDmb6mGvl4+vlNxWnbqcmgnLvgEqngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724521078; c=relaxed/simple;
	bh=ziytpaA+ne4kHZ6KdqHkQiK5JWCNoE4lmpIjTaiXqjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRbKGfP/3ufDDQRVTzndiqo9HKoTK/+QLRg/hov0ShS/T6kancOcN2BH/RcwHzdWtZnu7xhGg9UFcVCubTqLhNLxn2wwikHv06Id0Bq1s4NQ/QRGP7cJ+jG/bjBka9jGYIeCoAPOib6AazcfPoD9Yc0I3ODvbqhFr2fw1vicfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5/fjCIC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22F2C32781;
	Sat, 24 Aug 2024 17:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724521078;
	bh=ziytpaA+ne4kHZ6KdqHkQiK5JWCNoE4lmpIjTaiXqjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k5/fjCIC+aZExRL+7y9ZDFmgMKRBeR8ShnmAzT+NRqI7tTgvb2QoJH+uRR/zysg6c
	 eN1f3cptFff3MSF9OXBPhVJFwWUXi9dUBZo2EZtXT6k3UtNnvsf4XY7oQQ9NBi7DFk
	 ZRFVl35/pYUQlSHZZk4K6jWjVtPV2P3hjBlfE+OulQvkFQPPSA0ilwtmSNYvfyoA+b
	 cKxiI0H3hXOHOn0TwWRv86UgnB6thkdvQGXbnrIbUsOqQ+fXrJJxWkxppb2PCxYbtc
	 lcFSciOHx9wLyKNz4kAMA0Nf+4RSAJwVYumWfSXST1ACEyqwv31kYK3QDGrx4HFA+c
	 2V+XPe5SxUDVQ==
Date: Sat, 24 Aug 2024 10:37:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, rbc@meta.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <20240824103756.4fb39abc@kernel.org>
In-Reply-To: <20240823174855.3052334-1-leitao@debian.org>
References: <20240823174855.3052334-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Aug 2024 10:48:51 -0700 Breno Leitao wrote:
> These two patches make IP_NF_IPTABLES_LEGACY and IP6_NF_IPTABLES_LEGACY
> Kconfigs user selectable, avoiding creating an extra dependency by
> enabling some other config that would select IP{6}_NF_IPTABLES_LEGACY.

Resulting config in CI still differs quite a bit:

--- config.1	2024-08-23 14:19:10.000000000 -0700
+++ config	2024-08-24 05:18:52.000000000 -0700
@@ -1246,7 +1246,7 @@ CONFIG_NETFILTER_XT_MARK=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
 # CONFIG_NETFILTER_XT_TARGET_CT is not set
 # CONFIG_NETFILTER_XT_TARGET_DSCP is not set
-CONFIG_NETFILTER_XT_TARGET_HL=m
+# CONFIG_NETFILTER_XT_TARGET_HL is not set
 # CONFIG_NETFILTER_XT_TARGET_HMARK is not set
 # CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
 # CONFIG_NETFILTER_XT_TARGET_LED is not set
@@ -1333,22 +1333,21 @@ CONFIG_NF_TABLES_IPV4=y
 # CONFIG_NF_DUP_IPV4 is not set
 CONFIG_NF_LOG_ARP=m
 CONFIG_NF_LOG_IPV4=m
-CONFIG_NF_REJECT_IPV4=y
+CONFIG_NF_REJECT_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 # CONFIG_IP_NF_MATCH_AH is not set
 # CONFIG_IP_NF_MATCH_ECN is not set
 CONFIG_IP_NF_MATCH_RPFILTER=m
 # CONFIG_IP_NF_MATCH_TTL is not set
-CONFIG_IP_NF_FILTER=m
-CONFIG_IP_NF_TARGET_REJECT=m
+# CONFIG_IP_NF_FILTER is not set
+# CONFIG_IP_NF_TARGET_REJECT is not set
 # CONFIG_IP_NF_TARGET_SYNPROXY is not set
 CONFIG_IP_NF_NAT=m
-CONFIG_IP_NF_TARGET_MASQUERADE=m
+# CONFIG_IP_NF_TARGET_MASQUERADE is not set
 # CONFIG_IP_NF_TARGET_NETMAP is not set
 # CONFIG_IP_NF_TARGET_REDIRECT is not set
-CONFIG_IP_NF_MANGLE=m
+# CONFIG_IP_NF_MANGLE is not set
 # CONFIG_IP_NF_TARGET_ECN is not set
-CONFIG_IP_NF_TARGET_TTL=m
 CONFIG_IP_NF_RAW=m
 # CONFIG_IP_NF_ARPFILTER is not set
 # end of IP: Netfilter Configuration
@@ -1363,7 +1362,7 @@ CONFIG_NF_TABLES_IPV6=y
 # CONFIG_NFT_DUP_IPV6 is not set
 # CONFIG_NFT_FIB_IPV6 is not set
 # CONFIG_NF_DUP_IPV6 is not set
-CONFIG_NF_REJECT_IPV6=y
+CONFIG_NF_REJECT_IPV6=m
 CONFIG_NF_LOG_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
 # CONFIG_IP6_NF_MATCH_AH is not set
@@ -1376,11 +1375,10 @@ CONFIG_IP6_NF_MATCH_IPV6HEADER=m
 CONFIG_IP6_NF_MATCH_RPFILTER=m
 # CONFIG_IP6_NF_MATCH_RT is not set
 # CONFIG_IP6_NF_MATCH_SRH is not set
-# CONFIG_IP6_NF_TARGET_HL is not set
-CONFIG_IP6_NF_FILTER=m
-CONFIG_IP6_NF_TARGET_REJECT=m
+# CONFIG_IP6_NF_FILTER is not set
+# CONFIG_IP6_NF_TARGET_REJECT is not set
 # CONFIG_IP6_NF_TARGET_SYNPROXY is not set
-CONFIG_IP6_NF_MANGLE=m
+# CONFIG_IP6_NF_MANGLE is not set
 CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_NAT=m
 # CONFIG_IP6_NF_TARGET_MASQUERADE is not set
-- 
pw-bot: cr

