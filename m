Return-Path: <netdev+bounces-107811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 954FE91C6CE
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 21:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D02C1F25540
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 19:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B974770EE;
	Fri, 28 Jun 2024 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWXB3N/m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B3B770E2;
	Fri, 28 Jun 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603957; cv=none; b=ehpRvR/d2/BP4X815+XOFBVWSyeA5w1t20KgnrTs/vcZZGWj8ej73USPTzElicESX3QUtAMU2QCpETu8q5qVuQBoL7raXmQackANdmD+iHYVeMwShzmNyTLqDB5EQ5kY+glHhldmDksCjhBrwHZLMpXooMq/L19HVwf+1iWenLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603957; c=relaxed/simple;
	bh=IrdrG1tBxAVm62Qe7r1vkUwUOYUcKRkgMelfoOGYaEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3gaFNPo74ybB7we7BzyBA2QAGdwGpXdql0qRvTJnW6xU82OfeBB1aHSDz6q+tNNTytWWbKIC3P79CYw0b6/mujocuppaOcTMR7fVWhYYrKYJMwDH3wZ+HttEVX/4ZyFoVMdmKeGs2ScPt7CmbU13XrXIx74ky9TDhW2QXtFdB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWXB3N/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DE1C116B1;
	Fri, 28 Jun 2024 19:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719603956;
	bh=IrdrG1tBxAVm62Qe7r1vkUwUOYUcKRkgMelfoOGYaEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWXB3N/mUdNPhbCamjrxHD8R8Yo7qt0+CKPz/dpnFMbpReOJCqp5PIelD2eeNOGvX
	 aoL/qRoSHCNnWs4QltyAWYimylfw0DPe+Yv1HqTC2vjmO+bKRHQfAhVKcHxwOlwGcH
	 nsqgQwRa8WbC3HXVjh+Lwl2N1avfC5ytVuPGfqf+BK2oliuxEQNYuVfvOUum34e5tR
	 aYuDKi7oNneirj9yZ6e8UcNpixls6jILFm+alwwTDNyW37Uq2q9ELKCUM+BvaHbSoN
	 Qq1b6CMOztJcQf0Grl+uVHKvheDS/tz+KwpipUDfSQokapwerWZI5HkGevu4Sl9cWo
	 IllCG3pKVK6RQ==
Date: Fri, 28 Jun 2024 20:45:51 +0100
From: Simon Horman <horms@kernel.org>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
	i.maximets@ovn.org, dev@openvswitch.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/10] net: openvswitch: add psample action
Message-ID: <20240628194551.GH837606@kernel.org>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
 <20240628110559.3893562-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628110559.3893562-6-amorenoz@redhat.com>

On Fri, Jun 28, 2024 at 01:05:41PM +0200, Adrian Moreno wrote:
> Add support for a new action: psample.
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

> diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
> index efc82c318fa2..07086759556b 100644
> --- a/include/uapi/linux/openvswitch.h
> +++ b/include/uapi/linux/openvswitch.h
> @@ -914,6 +914,31 @@ struct check_pkt_len_arg {
>  };
>  #endif
>  
> +#define OVS_PSAMPLE_COOKIE_MAX_SIZE 16
> +/**
> + * enum ovs_pample_attr - Attributes for %OVS_ACTION_ATTR_PSAMPLE

nit: s/ovs_pample_attr/ovs_psample_attr/

> + * action.
> + *
> + * @OVS_PSAMPLE_ATTR_GROUP: 32-bit number to identify the source of the
> + * sample.
> + * @OVS_PSAMPLE_ATTR_COOKIE: An optional variable-length binary cookie that
> + * contains user-defined metadata. The maximum length is
> + * OVS_PSAMPLE_COOKIE_MAX_SIZE bytes.
> + *
> + * Sends the packet to the psample multicast group with the specified group and
> + * cookie. It is possible to combine this action with the
> + * %OVS_ACTION_ATTR_TRUNC action to limit the size of the sample.
> + */
> +enum ovs_psample_attr {
> +	OVS_PSAMPLE_ATTR_GROUP = 1,	/* u32 number. */
> +	OVS_PSAMPLE_ATTR_COOKIE,	/* Optional, user specified cookie. */
> +
> +	/* private: */
> +	__OVS_PSAMPLE_ATTR_MAX
> +};

...

