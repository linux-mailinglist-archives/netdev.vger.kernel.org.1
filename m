Return-Path: <netdev+bounces-280321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHnlHeZo6GlZKAIAu9opvQ
	(envelope-from <netdev+bounces-280321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:21:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81F4425CB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 619A8300230C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 06:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F081F3D56;
	Wed, 22 Apr 2026 06:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0jtz2rw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC2317BA6
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 06:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838884; cv=none; b=EyN1fnV5HetsF49VKdXgCvXWvAErTMLFi6QSUrK7pCcV7Bmkti8IYlLMTciLm+BiqE5SI3GYZ/zTv0WBJJi3LN+tI0vMPvWjHfVUZYzYN6pnj03+3O9k74rYXLakOB49fO3ShQuYH7YfBx2gRtMYVSe3+EjDjALPa/N1qp7hrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838884; c=relaxed/simple;
	bh=eDYnCUq99hOlEW3igTZ9Gu88HgiekLbK+GBmHOZYJN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EA44FtOYU+7ng4BuDPOaYEA+q2ftdw5xTy2YW+YHhymp0izYK0nYWb2meVUjyPzpkSwd9NxBPxCYt75A9+svkVVtAnPt4vtuaHKhKlJNrzao2bM04s1LfBdrJrBCxXhYa1ajSxt51o3li6zJIPfMbAqqJOoe3ejx0jEPNrknWhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0jtz2rw; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776838882; x=1808374882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eDYnCUq99hOlEW3igTZ9Gu88HgiekLbK+GBmHOZYJN4=;
  b=F0jtz2rwN4iZt/34pyU1NuoPOwd49RoPKh2yVb1i2dlEdSec8fHppUm1
   ywO+TiOvpf3THPhlGag6O2GKCDTS3c871nkPaeHkBP1plbgvQDoQ7r5lP
   cIwExc210Ap2Is4phq3CP6kjvEVXsEvao5g8ZreHeGH7j+DKho+YQ1JSj
   EmcxjsbEbVoHhN9Ab2XqGkuWCllwRLavuYCM+PeuUTg2xPH5hrnK/Ni3x
   HhJDTBqyohMfkBsVCmCBtydpYszSzGxsjrK0dEU/2Ercn0H7eUDfRrXGZ
   GFIhfP/u8HRcMtOxXz1jXhNI2iQASxSXXYi3yyuDmVhYLne5WEKOurtTB
   Q==;
X-CSE-ConnectionGUID: NrXVIZ/eT76SideuJ/KBvg==
X-CSE-MsgGUID: jwa9f6GBRl6Ypz09p+qn6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81650199"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81650199"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:21:21 -0700
X-CSE-ConnectionGUID: HY1aDMW1SMqUY2TG4U7hIg==
X-CSE-MsgGUID: 6o5yNclpTqyY52pVY0I1yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="227666720"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2026 23:21:17 -0700
Date: Wed, 22 Apr 2026 08:21:14 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, simona.vetter@ffwll.ch, airlied@gmail.com,
	kuba@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	maarten@lankhorst.se, zachary.mckevitt@oss.qualcomm.com,
	rodrigo.vivi@intel.com, michal.wajdeczko@intel.com,
	matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
	mallesh.koujalagi@intel.com, soham.purkait@intel.com,
	anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v1 02/11] drm/ras: Introduce get-error-threshold
Message-ID: <aeho2grP5GGBGcDL@black.igk.intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
 <20260417211730.837345-3-raag.jadav@intel.com>
 <0c855393-be55-497d-aabe-fbe72e37321f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c855393-be55-497d-aabe-fbe72e37321f@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,vger.kernel.org,ffwll.ch,gmail.com,kernel.org,amd.com,davemloft.net,redhat.com,google.com,lankhorst.se,oss.qualcomm.com,intel.com,linux.intel.com];
	TAGGED_FROM(0.00)[bounces-280321-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F81F4425CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 11:19:36AM +0530, Tauro, Riana wrote:
> On 4/18/2026 2:46 AM, Raag Jadav wrote:
> > Add get-error-threshold command support which allows querying threshold
> > value of the error. Threshold in RAS context means the number of errors
> > the hardware is expected to accumulate before it raises them to software.
> > This is to have a fine grained control over error notifications that are
> > raised by the hardware.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >   Documentation/gpu/drm-ras.rst            |   8 ++
> >   Documentation/netlink/specs/drm_ras.yaml |  37 ++++++++
> >   drivers/gpu/drm/drm_ras.c                | 103 +++++++++++++++++++++++
> >   drivers/gpu/drm/drm_ras_nl.c             |  13 +++
> >   drivers/gpu/drm/drm_ras_nl.h             |   2 +
> >   include/drm/drm_ras.h                    |  14 +++
> >   include/uapi/drm/drm_ras.h               |  11 +++
> >   7 files changed, 188 insertions(+)
> > 
> > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > index 70b246a78fc8..6443dfd1677f 100644
> > --- a/Documentation/gpu/drm-ras.rst
> > +++ b/Documentation/gpu/drm-ras.rst
> > @@ -52,6 +52,8 @@ User space tools can:
> >     as a parameter.
> >   * Query specific error counter values with the ``get-error-counter`` command, using both
> >     ``node-id`` and ``error-id`` as parameters.
> > +* Query specific error threshold value with the ``get-error-threshold`` command, using both
> > +  ``node-id`` and ``error-id`` as parameters.
> Also define what is a thresold. How can it be used?

Sure, I'll append commit message description here.

> >   YAML-based Interface
> >   --------------------
> > @@ -101,3 +103,9 @@ Example: Query an error counter for a given node
> >       sudo ynl --family drm_ras --do get-error-counter --json '{"node-id":0, "error-id":1}'
> >       {'error-id': 1, 'error-name': 'error_name1', 'error-value': 0}
> > +Example: Query threshold value of a given error
> > +
> > +.. code-block:: bash
> > +
> > +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> > +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 0}
> > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > index 79af25dac3c5..95a939fb987d 100644
> > --- a/Documentation/netlink/specs/drm_ras.yaml
> > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > @@ -69,6 +69,25 @@ attribute-sets:
> >           name: error-value
> >           type: u32
> >           doc: Current value of the requested error counter.
> > +  -
> > +    name: error-threshold-attrs
> > +    attributes:
> > +      -
> > +        name: node-id
> > +        type: u32
> > +        doc: Node ID targeted by this operation.
> > +      -
> > +        name: error-id
> > +        type: u32
> > +        doc: Unique identifier for a specific error within the node.
> > +      -
> > +        name: error-name
> > +        type: string
> > +        doc: Name of the error.
> > +      -
> > +        name: error-threshold
> > +        type: u32
> > +        doc: Threshold value of the error.
> >   operations:
> >     list:
> > @@ -113,3 +132,21 @@ operations:
> >               - node-id
> >           reply:
> >             attributes: *errorinfo
> > +    -
> > +      name: get-error-threshold
> > +      doc: >-
> > +           Retrieve threshold value of the error.
> > +           The response includes the id, the name, and current threshold
> > +           value of the error.
> > +      attribute-set: error-threshold-attrs
> > +      flags: [admin-perm]
> > +      do:
> > +        request:
> > +          attributes:
> > +            - node-id
> > +            - error-id
> > +        reply:
> > +          attributes:
> > +            - error-id
> > +            - error-name
> > +            - error-threshold
> > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > index 1f7435d60f11..d2d853d5d69c 100644
> > --- a/drivers/gpu/drm/drm_ras.c
> > +++ b/drivers/gpu/drm/drm_ras.c
> > @@ -37,6 +37,10 @@
> >    *    Returns all counters of a node if only Node ID is provided or specific
> >    *    error counters.
> >    *
> > + * 3. GET_ERROR_THRESHOLD: Query threshold value of the error.
> > + *    Userspace must provide Node ID and Error ID.
> > + *    Returns the threshold value of a specific error.
> > + *
> >    * Node registration:
> >    *
> >    * - drm_ras_node_register(): Registers a new node and assigns
> > @@ -66,6 +70,8 @@
> >    *   operation, fetching all counters from a specific node.
> >    * - drm_ras_nl_get_error_counter_doit(): Implements the GET_ERROR_COUNTER doit
> >    *   operation, fetching a counter value from a specific node.
> > + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> > + *   operation, fetching the threshold value of a specific error.
> >    */
> >   static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > @@ -162,6 +168,22 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
> >   	return node->query_error_counter(node, error_id, name, value);
> >   }
> > +static int get_node_error_threshold(u32 node_id, u32 error_id,
> > +				    const char **name, u32 *value)
> > +{
> > +	struct drm_ras_node *node;
> > +
> > +	node = xa_load(&drm_ras_xa, node_id);
> > +	if (!node || !node->query_error_threshold)
> > +		return -ENOENT;
> 
> For the absence of the function, return -EOPNOTSUPP

Works for me, but then it should be consistent for all commands.

> > +
> > +	if (error_id < node->error_counter_range.first ||
> > +	    error_id > node->error_counter_range.last)
> > +		return -EINVAL;
> > +
> > +	return node->query_error_threshold(node, error_id, name, value);
> > +}
> > +
> >   static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
> >   				   const char *error_name, u32 value)
> >   {
> > @@ -180,6 +202,24 @@ static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
> >   			   value);
> >   }
> > +static int msg_reply_threshold_value(struct sk_buff *msg, u32 error_id,
> > +				     const char *error_name, u32 value)
> > +{
> > +	int ret;
> > +
> > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID, error_id);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_NAME,
> > +			     error_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
> > +			   value);
> > +}
> > +
> >   static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
> >   				    u32 error_id)
> >   {
> > @@ -216,6 +256,42 @@ static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
> >   	return genlmsg_reply(msg, info);
> >   }
> > +static int doit_reply_threshold_value(struct genl_info *info, u32 node_id,
> > +				      u32 error_id)
> > +{
> > +	struct sk_buff *msg;
> > +	struct nlattr *hdr;
> > +	const char *error_name;
> > +	u32 value;
> > +	int ret;
> > +
> > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > +	if (!msg)
> > +		return -ENOMEM;
> > +
> > +	hdr = genlmsg_iput(msg, info);
> > +	if (!hdr) {
> > +		nlmsg_free(msg);
> > +		return -EMSGSIZE;
> > +	}
> > +
> > +	ret = get_node_error_threshold(node_id, error_id,
> > +				       &error_name, &value);
> > +	if (ret)
> > +		return ret;
> 
> You have to cancel and free genlmsg here.
> Looks like the counter patch also has the same issue. Will send out a fix.

Yeah, failed attempt at stealing your code :(

Raag

> > +	ret = msg_reply_threshold_value(msg, error_id, error_name, value);
> > +	if (ret) {
> > +		genlmsg_cancel(msg, hdr);
> > +		nlmsg_free(msg);
> > +		return ret;
> > +	}
> > +
> > +	genlmsg_end(msg, hdr);
> > +
> > +	return genlmsg_reply(msg, info);
> > +}
> > +
> >   /**
> >    * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
> >    * @skb: Netlink message buffer
> > @@ -314,6 +390,33 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> >   	return doit_reply_counter_value(info, node_id, error_id);
> >   }
> > +/**
> > + * drm_ras_nl_get_error_threshold_doit() - Query threshold value of the error
> Nit: an
> 
> Thanks
> Riana
> > + * @skb: Netlink message buffer
> > + * @info: Generic Netlink info containing attributes of the request
> > + *
> > + * Extracts the node ID and error ID from the netlink attributes and
> > + * retrieves the current threshold of the corresponding error. Sends the
> > + * result back to the requesting user via the standard Genl reply.
> > + *
> > + * Return: 0 on success, or negative errno on failure.
> > + */
> > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > +				      struct genl_info *info)
> > +{
> > +	u32 node_id, error_id;
> > +
> > +	if (!info->attrs ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID) ||
> > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID))
> > +		return -EINVAL;
> > +
> > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID]);
> > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID]);
> > +
> > +	return doit_reply_threshold_value(info, node_id, error_id);
> > +}
> > +
> >   /**
> >    * drm_ras_node_register() - Register a new RAS node
> >    * @node: Node structure to register
> > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > index 16803d0c4a44..48e231734f4d 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.c
> > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > @@ -22,6 +22,12 @@ static const struct nla_policy drm_ras_get_error_counter_dump_nl_policy[DRM_RAS_
> >   	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> >   };
> > +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> > +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID + 1] = {
> > +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > +	[DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > +};
> > +
> >   /* Ops table for drm_ras */
> >   static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   	{
> > @@ -43,6 +49,13 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> >   		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID,
> >   		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> >   	},
> > +	{
> > +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > +		.doit		= drm_ras_nl_get_error_threshold_doit,
> > +		.policy		= drm_ras_get_error_threshold_nl_policy,
> > +		.maxattr	= DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
> > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > +	},
> >   };
> >   struct genl_family drm_ras_nl_family __ro_after_init = {
> > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > index 06ccd9342773..540fe22e2312 100644
> > --- a/drivers/gpu/drm/drm_ras_nl.h
> > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > @@ -18,6 +18,8 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
> >   				      struct genl_info *info);
> >   int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> >   					struct netlink_callback *cb);
> > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > +					struct genl_info *info);
> >   extern struct genl_family drm_ras_nl_family;
> > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > index 5d50209e51db..50cee70bd065 100644
> > --- a/include/drm/drm_ras.h
> > +++ b/include/drm/drm_ras.h
> > @@ -57,6 +57,20 @@ struct drm_ras_node {
> >   	 */
> >   	int (*query_error_counter)(struct drm_ras_node *node, u32 error_id,
> >   				   const char **name, u32 *val);
> > +	/**
> > +	 * @query_error_threshold:
> > +	 *
> > +	 * This callback is used by drm-ras to query threshold value of a
> > +	 * specific error.
> > +	 *
> > +	 * Driver should expect query_error_threshold() to be called with
> > +	 * error_id from `error_counter_range.first` to
> > +	 * `error_counter_range.last`.
> > +	 *
> > +	 * Returns: 0 on success, negative error code on failure.
> > +	 */
> > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id,
> > +				     const char **name, u32 *val);
> >   	/** @priv: Driver private data */
> >   	void *priv;
> > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > index 5f40fa5b869d..49c5ca497d73 100644
> > --- a/include/uapi/drm/drm_ras.h
> > +++ b/include/uapi/drm/drm_ras.h
> > @@ -38,9 +38,20 @@ enum {
> >   	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> >   };
> > +enum {
> > +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_NODE_ID = 1,
> > +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_ID,
> > +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_NAME,
> > +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_ERROR_THRESHOLD,
> > +
> > +	__DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX,
> > +	DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX = (__DRM_RAS_A_ERROR_THRESHOLD_ATTRS_MAX - 1)
> > +};
> > +
> >   enum {
> >   	DRM_RAS_CMD_LIST_NODES = 1,
> >   	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> >   	__DRM_RAS_CMD_MAX,
> >   	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)

