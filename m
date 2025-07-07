Return-Path: <netdev+bounces-204519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695B6AFAFE2
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CD33B1D99
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3006D28BABD;
	Mon,  7 Jul 2025 09:37:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE9728B41D
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881036; cv=none; b=rFWEx6g26EvSNnGzc86leuwpO6qlR2v8GIPPUiZbFwtKv2IggkW9cZSIIF98x7+SI27Jbf2pm/ldPrd45APLgn9KlPxQ+ihOHizEVAWcxVZ4hnutXCAONutcLQh1XH0a1kIFSGDgX5GrxYLxjZPG1xn4EmUEo426HR9PiU+Q+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881036; c=relaxed/simple;
	bh=JGOFzf8FYf1+D3TupbqRr5DVwxgxSvRWRLZy8SIFr2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sX/x5+US3iEh9K7iD0PSbECtsYn4YxEMScRuOL39j0fEQURJ+C/MXTt15s8CRYDHLCRv242dZjKje1Az9AccaYS07BQoTLybw7xmns3gE1Fz6RrHzZOe8oG/MV1TD/13klYLcuH42AX54yC/on8m+1m5S1K7qcYr+4pOd3zsv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.144] (unknown [185.238.219.24])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id B695B61E647AC;
	Mon, 07 Jul 2025 11:36:38 +0200 (CEST)
Message-ID: <667b6c18-76d2-4ea7-9133-b857ffb05795@molgen.mpg.de>
Date: Mon, 7 Jul 2025 11:36:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v2 1/2] devlink: allow driver to
 freely name interfaces
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org, dhowells@redhat.com, David.Kaplan@amd.com,
 jiri@resnulli.us, przemyslaw.kitszel@intel.com
References: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250707085837.1461086-1-jedrzej.jagielski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Jedrzej,


Thank you for your patch.


Am 07.07.25 um 10:58 schrieb Jedrzej Jagielski:
> Currently when adding devlink port it is prohibited to let
> a driver name an interface on its own. In some scenarios
> it would not be preferable to provide such limitation,
> eg some compatibility purposes.

Re-flowing for 72 characters per line would save one line.

> Add flag skip_phys_port_name_get to devlink_port_attrs struct
> which indicates if devlink should not alter name of interface.
> 
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
> v2: add skip_phys_port_name_get flag to skip changing if name
> ---
>   include/net/devlink.h | 7 ++++++-
>   net/devlink/port.c    | 3 +++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/devlink.h b/include/net/devlink.h
> index 0091f23a40f7..414ae25de897 100644
> --- a/include/net/devlink.h
> +++ b/include/net/devlink.h
> @@ -78,6 +78,7 @@ struct devlink_port_pci_sf_attrs {
>    * @flavour: flavour of the port
>    * @split: indicates if this is split port
>    * @splittable: indicates if the port can be split.
> + * @skip_phys_port_name_get: if set devlink doesn't alter interface name
>    * @lanes: maximum number of lanes the port supports. 0 value is not passed to netlink.
>    * @switch_id: if the port is part of switch, this is buffer with ID, otherwise this is NULL
>    * @phys: physical port attributes
> @@ -87,7 +88,11 @@ struct devlink_port_pci_sf_attrs {
>    */
>   struct devlink_port_attrs {
>   	u8 split:1,
> -	   splittable:1;
> +	   splittable:1,
> +	   skip_phys_port_name_get:1; /* This is for compatibility only,
> +				       * newly added driver/port instance
> +				       * should never set this.
> +				       */
>   	u32 lanes;
>   	enum devlink_port_flavour flavour;
>   	struct netdev_phys_item_id switch_id;
> diff --git a/net/devlink/port.c b/net/devlink/port.c
> index 939081a0e615..bf52c8a57992 100644
> --- a/net/devlink/port.c
> +++ b/net/devlink/port.c
> @@ -1522,6 +1522,9 @@ static int __devlink_port_phys_port_name_get(struct devlink_port *devlink_port,
>   	if (!devlink_port->attrs_set)
>   		return -EOPNOTSUPP;
>   
> +	if (devlink_port->attrs.skip_phys_port_name_get)
> +		return 0;
> +
>   	switch (attrs->flavour) {
>   	case DEVLINK_PORT_FLAVOUR_PHYSICAL:
>   		if (devlink_port->linecard)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

