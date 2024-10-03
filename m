Return-Path: <netdev+bounces-131432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53598E7E2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820862856DC
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92610BA49;
	Thu,  3 Oct 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKQPDs/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEFB8F64
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916092; cv=none; b=r/si1NVGiNy0O/gS2NwBJ3Qi46aC0bjcUxz2M9la2aeGQOOEj3a3C0sWuMnUf2TW+VxSJk2oDFD0MZ+Gu4WIZ4ZLdXKKWVmManqA9rZemQqINrgPxc6ne8wzwFhSvclxk7ultMegPbKqpNfPv8Hnf4fQFO5M+PSeV64oMPRGyVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916092; c=relaxed/simple;
	bh=t7XvNoY4TBo5WAcuN78hwQ8Cn0tG4M8Q/rUBlMWXbqI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bKOQdeWOB41e3ilx/ZqpdsdyjoTIqmLW59HA9IgYzZ66nP3wjog8EHzucBwqKpao8AMBW0OB2oeIuApwMCm/tVUMCtf8Lw+7ai7aeXPvA6cBovh/oMxTyObpeAOy5noiehKiFegna7wF+eOep6eq4k69G4EW8yIrdBkkozWecHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKQPDs/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A423AC4CEC2;
	Thu,  3 Oct 2024 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916091;
	bh=t7XvNoY4TBo5WAcuN78hwQ8Cn0tG4M8Q/rUBlMWXbqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OKQPDs/mkFQfANraT5KSqdzKHwrIlUPVNlvP3uFxmAzqQ6iICI6xciy1+Kym97l7z
	 iCwxo7DIY++1t1c/cPrlBzdD1jxvA0+Vn0uWP+/t1H3G97nt7Ed7VC1UOnwZcAjXYe
	 c4FHRvQmgEbNBURc/I1IvKv2RklU3c50H6KfiV3VKR0FPGTHMa4ze8MA5N+GKM4Oas
	 wBZ3dRH/Qr22BPtzgu2P+YF/lg7JuG4WSJJqPnnW6aUxWSNfcLcw49kzp+6g19OaX6
	 GAirV26iMM+XKqrMVg7G2PMdKH7sLrCwjAbdmyYLNlo4x9BRLJ0xic8bnObBzZeTON
	 00Lq63rYQpEDw==
Date: Wed, 2 Oct 2024 17:41:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Jeffrey Ji
 <jeffreyji@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/2] net: add
 IFLA_MAX_PACING_OFFLOAD_HORIZON device attribute
Message-ID: <20241002174130.5e976cad@kernel.org>
In-Reply-To: <20241002151220.349571-2-edumazet@google.com>
References: <20241002151220.349571-1-edumazet@google.com>
	<20241002151220.349571-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 15:12:18 +0000 Eric Dumazet wrote:
> diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> index 6dc258993b177093a77317ee5f2deab97fb04674..506ba9c80e83a5039f003c9def8b4fce41f43847 100644
> --- a/include/uapi/linux/if_link.h
> +++ b/include/uapi/linux/if_link.h
> @@ -377,6 +377,7 @@ enum {
>  	IFLA_GSO_IPV4_MAX_SIZE,
>  	IFLA_GRO_IPV4_MAX_SIZE,
>  	IFLA_DPLL_PIN,
> +	IFLA_MAX_PACING_OFFLOAD_HORIZON,
>  	__IFLA_MAX
>  };

Sorry for not catching this earlier, looks like CI is upset that
we didn't add this to the YAML. Please squash or LMK if you prefer
for me to follow up:

diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
index 0c4d5d40cae9..d7131a1afadf 100644
--- a/Documentation/netlink/specs/rt_link.yaml
+++ b/Documentation/netlink/specs/rt_link.yaml
@@ -1137,6 +1137,10 @@ protonum: 0
         name: dpll-pin
         type: nest
         nested-attributes: link-dpll-pin-attrs
+      -
+        name: max-pacing-offload-horizon
+        type: uint
+        doc: EDT offload horizon supported by the device (in nsec).
   -
     name: af-spec-attrs
     attributes:

