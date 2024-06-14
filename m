Return-Path: <netdev+bounces-103666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9BE908FC2
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F70B282DE9
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58416C696;
	Fri, 14 Jun 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmAofsK2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF515F418;
	Fri, 14 Jun 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381616; cv=none; b=kYTKUZuN5aZ9lItYfCjMEbTc0sPJYEPIr/eORbBN0Vla5SqBbEGAUY08UI/ORUezuCJbS1ufhG7H57EhojhKG1XRUAJ5N5UB5O+oXTNsGlS3NBcTKv/nCDVMk+ZX7bXqwy2mpi6twMMFFVBjEQN4XTs5Ng4+RxKpeHJcFLIelUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381616; c=relaxed/simple;
	bh=huBdpGXVS4yt0ijTMlYI+RpVR7WihNOcevpzIq13fAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZki9BKWeQE27As6flk6TrenbKiRs0kENfPCwWIFOjKMu32RRxeJWHFoa8jLxsX5k00rpSPXOp/tUXDU8Wjo/18714m3F+7HgOIXsYJbg3EEEGLxiL33oU9RyyF5/xfurTMaQZWbg6V95osYyVieDLPKADtG29aaVYMhVrXRb1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmAofsK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB2BC2BD10;
	Fri, 14 Jun 2024 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718381615;
	bh=huBdpGXVS4yt0ijTMlYI+RpVR7WihNOcevpzIq13fAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmAofsK2OXMemYmiHGLIxuDQkKzscNbKQrN9KJCmKGgzHnN6EVJ0WjceWgB6CaQMf
	 kSNg4TZ5iiahADW2KIOnvySnRBQkbS3DC25uzRGz8nymne4xeEE9sx50tiloBfw0aD
	 t+L1NKyummdMt8RjDn1hZf0s74I4MVU+mmjby9jWMfZ2RUuxJ8XCYnT0fpfV5y6yDh
	 yYrYbdQzlXWkGZd+zlmiZ/XnO2eOsIjCX00XoWpS4B5s3igwA/Sa2NaydesJjYN7Kn
	 RZ6aKNw5MlPiXNnOgZbB75qzaptQk2XTG0Vqo+MkTfm+/goTZDhNGoWnEHGbKKctrf
	 NOGtKXQ4EZm2w==
Date: Fri, 14 Jun 2024 17:13:31 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 5/9] net: openvswitch: add emit_sample action
Message-ID: <20240614161331.GQ8447@kernel.org>
References: <20240603185647.2310748-1-amorenoz@redhat.com>
 <20240603185647.2310748-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603185647.2310748-6-amorenoz@redhat.com>

On Mon, Jun 03, 2024 at 08:56:39PM +0200, Adrian Moreno wrote:
> Add support for a new action: emit_sample.
> 
> This action accepts a u32 group id and a variable-length cookie and uses
> the psample multicast group to make the packet available for
> observability.
> 
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

...

> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c

...

> @@ -1299,6 +1304,46 @@ static int execute_dec_ttl(struct sk_buff *skb, struct sw_flow_key *key)
>  	return 0;
>  }
>  
> +static int execute_emit_sample(struct datapath *dp, struct sk_buff *skb,
> +			       const struct sw_flow_key *key,
> +			       const struct nlattr *attr)
> +{
> +#if IS_ENABLED(CONFIG_PSAMPLE)
> +	struct psample_group psample_group = {};
> +	struct psample_metadata md = {};
> +	struct vport *input_vport;
> +	const struct nlattr *a;
> +	int rem;
> +
> +	for (a = nla_data(attr), rem = nla_len(attr); rem > 0;
> +	     a = nla_next(a, &rem)) {
> +		switch (nla_type(a)) {
> +		case OVS_EMIT_SAMPLE_ATTR_GROUP:
> +			psample_group.group_num = nla_get_u32(a);
> +			break;
> +
> +		case OVS_EMIT_SAMPLE_ATTR_COOKIE:
> +			md.user_cookie = nla_data(a);
> +			md.user_cookie_len = nla_len(a);
> +			break;
> +		}
> +	}
> +
> +	psample_group.net = ovs_dp_get_net(dp);
> +
> +	input_vport = ovs_vport_rcu(dp, key->phy.in_port);
> +	if (!input_vport)
> +		input_vport = ovs_vport_rcu(dp, OVSP_LOCAL);
> +
> +	md.in_ifindex = input_vport->dev->ifindex;
> +	md.trunc_size = skb->len - OVS_CB(skb)->cutlen;
> +
> +	psample_sample_packet(&psample_group, skb, 0, &md);
> +#endif
> +
> +	return 0;
> +}
> +
>  /* Execute a list of actions against 'skb'. */
>  static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			      struct sw_flow_key *key,
> @@ -1502,6 +1547,11 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
>  			ovs_kfree_skb_reason(skb, reason);
>  			return 0;
>  		}
> +
> +		case OVS_ACTION_ATTR_EMIT_SAMPLE:
> +			err = execute_emit_sample(dp, skb, key, a);
> +			OVS_CB(skb)->cutlen = 0;
> +			break;
>  		}

Hi Adrian,

execute_emit_sample always returns 0, and it seems that err will always
be 0 when the code above is executed. So perhaps the return type
of execute_emit_sample could be changed to void and the code above be
updated not to set err.

Other than that, which I don't feel particularly strongly about,
this looks good to me.

...

