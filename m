Return-Path: <netdev+bounces-126968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79E9736D8
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C37F1C21404
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED1BD18C913;
	Tue, 10 Sep 2024 12:08:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A518DF8F
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725970135; cv=none; b=bHLUlA6lPQ2iyaeJjFub6rxZi1pjcw+J0aySY+yHloHhkL4cgpyfxKOH4ngucXCsnF9yL5cTZub8CodKOcoqC1uLxI7arp9gSfDQ+aj+ocV/qEWkgh2VnMBV4pQFpcayq0dnoPlzgcPqZcKrTy6QlTf9Tjeg23ISFvMapzRJVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725970135; c=relaxed/simple;
	bh=RVz8DbwhqDruU0J7absuuL2O2Z+T57T01A8K9SkkrGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoKaFYM/xPZXsiIJg6d60WKHTI6+fXIsrCmSGyq4Oe5p0u9YrNFMEIF1/4P36JOPhYxA7kVQtq3TyY9vlsNIYwm5TXM/4sG6pPUVphmpw+d5NVtw7gJ77zxdQdmwpaJHhYhO8rqQyZ9BdTVXD+Q8EDX8VwyTtfYgs+WSSGm3Arw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 505A761E5FE05;
	Tue, 10 Sep 2024 14:08:02 +0200 (CEST)
Message-ID: <688515d9-9bf2-4939-a3c6-9b22a886dfb9@molgen.mpg.de>
Date: Tue, 10 Sep 2024 14:08:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH v7 net-next 02/15] netlink: spec: add
 shaper YAML spec
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Donald Hunter <donald.hunter@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, edumazet@google.com,
 Madhu Chittim <madhu.chittim@intel.com>, anthony.l.nguyen@intel.com,
 Simon Horman <horms@kernel.org>, przemyslaw.kitszel@intel.com,
 Jakub Kicinski <kuba@kernel.org>, intel-wired-lan@lists.osuosl.org,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>
References: <cover.1725919039.git.pabeni@redhat.com>
 <4ac641b1cb3d0b78de3571e394e4c7d2239714f7.1725919039.git.pabeni@redhat.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4ac641b1cb3d0b78de3571e394e4c7d2239714f7.1725919039.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Paolo,


Thank you for the patch. Some minor nits below.


Am 10.09.24 um 00:09 schrieb Paolo Abeni:
> Define the user-space visible interface to query, configure and delete
> network shapers via yaml definition.
> 
> Add dummy implementations for the relevant NL callbacks.
> 
> set() and delete() operations touch a single shaper creating/updating or
> deleting it.
> The group() operation creates a shaper's group, nesting multiple input
> shapers under the specified output shaper.
> 
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v6 -> v7:
>   - s/Minimum g/G/
>   - shaper attributes for set() op are not nested anymore
>   - node attributes for group() op are not nested anymore
> 
> v5 -> v6:
>   - moved back ifindex out of binding attr, drop the latter
>   - restrict leaves attributes to scheduling-related ones
> 
> v4 -> v5:
>   - moved ifindex under the binding attr
>   - moved id, scope to new attr set
>   - rename 'root' as 'node'
>   - deleted unused 'info' subset
>   - a lot of doc update and fixup
>   - removed empty black line at MAKEFILE eof
> 
> v3 -> v4:
>   - spec file rename
>   - always use '@' for references
>   - detached scope -> node scope
>   - inputs/output -> leaves/root
>   - deduplicate leaves/root policy
>   - get/dump/group return ifindex, too
>   - added some general introduction to the doc
> 
> RFC v1 -> RFC v2:
>   - u64 -> uint
>   - net_shapers -> net-shapers
>   - documented all the attributes
>   - dropped [ admin-perm ] for get() op
>   - group op
>   - set/delete touch a single shaper
> ---
>   Documentation/netlink/specs/net_shaper.yaml | 276 ++++++++++++++++++++
>   MAINTAINERS                                 |   1 +
>   include/uapi/linux/net_shaper.h             |  78 ++++++
>   net/Kconfig                                 |   3 +
>   net/Makefile                                |   1 +
>   net/shaper/Makefile                         |   8 +
>   net/shaper/shaper.c                         |  55 ++++
>   net/shaper/shaper_nl_gen.c                  | 125 +++++++++
>   net/shaper/shaper_nl_gen.h                  |  34 +++
>   9 files changed, 581 insertions(+)
>   create mode 100644 Documentation/netlink/specs/net_shaper.yaml
>   create mode 100644 include/uapi/linux/net_shaper.h
>   create mode 100644 net/shaper/Makefile
>   create mode 100644 net/shaper/shaper.c
>   create mode 100644 net/shaper/shaper_nl_gen.c
>   create mode 100644 net/shaper/shaper_nl_gen.h
> 
> diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
> new file mode 100644
> index 000000000000..cfe55af41d9d
> --- /dev/null
> +++ b/Documentation/netlink/specs/net_shaper.yaml
> @@ -0,0 +1,276 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: net-shaper
> +
> +doc: |
> +  Networking HW rate limiting configuration.
> +
> +  This API allows configuring HW shapers available on the network
> +  devices at different levels (queues, network device) and allows
> +  arbitrary manipulation of the scheduling tree of the involved
> +  shapers.
> +
> +  Each @shaper is identified within the given device, by an @handle,

*a* handle?

> +  comprising both a @scope and an @id.
> +
> +  Depending on the @scope value, the shapers are attached to specific
> +  HW objects (queues, devices) or, for @node scope, represent a
> +  scheduling group, that can be placed in an arbitrary location of
> +  the scheduling tree.
> +
> +  Shapers can be created with two different operations: the @set
> +  operation, to create and update a single "attached" shaper, and
> +  the @group operation, to create and update a scheduling

I think no comma needed before the two *to*s.

> +  group. Only the @group operation can create @node scope shapers

Add a dot/period at the end?

> +
> +  Existing shapers can be deleted/reset via the @delete operation.
> +
> +  The user can query the running configuration via the @get operation.
> +
> +definitions:
> +  -
> +    type: enum
> +    name: scope
> +    doc: Defines the shaper @id interpretation.
> +    render-max: true
> +    entries:
> +      - name: unspec
> +        doc: The scope is not specified.
> +      -
> +        name: netdev
> +        doc: The main shaper for the given network device.
> +      -
> +        name: queue
> +        doc: |
> +            The shaper is attached to the given device queue,
> +            the @id represents the queue number.
> +      -
> +        name: node
> +        doc: |
> +             The shaper allows grouping of queues or other
> +             node shapers; can be nested in either @netdev
> +             shapers or other @node shapers, allowing placement
> +             in any location of the scheduling tree, except
> +             leaves and root.
> +  -
> +    type: enum
> +    name: metric
> +    doc: Different metric supported by the shaper.
> +    entries:
> +      -
> +        name: bps
> +        doc: Shaper operates on a bits per second basis.
> +      -
> +        name: pps
> +        doc: Shaper operates on a packets per second basis.
> +
> +attribute-sets:
> +  -
> +    name: net-shaper
> +    attributes:
> +      -
> +        name: handle
> +        type: nest
> +        nested-attributes: handle
> +        doc: Unique identifier for the given shaper inside the owning device.
> +      -
> +        name: metric
> +        type: u32
> +        enum: metric
> +        doc: Metric used by the given shaper for bw-min, bw-max and burst.
> +      -
> +        name: bw-min
> +        type: uint
> +        doc: Guaranteed bandwidth for the given shaper.
> +      -
> +        name: bw-max
> +        type: uint
> +        doc: Maximum bandwidth for the given shaper or 0 when unlimited.
> +      -
> +        name: burst
> +        type: uint
> +        doc: |
> +          Maximum burst-size for shaping. Should not be interpreted
> +          as a quantum.
> +      -
> +        name: priority
> +        type: u32
> +        doc: |
> +          Scheduling priority for the given shaper. The priority
> +          scheduling is applied to sibling shapers.
> +      -
> +        name: weight
> +        type: u32
> +        doc: |
> +          Relative weight for round robin scheduling of the
> +          given shaper.
> +          The scheduling is applied to all sibling shapers
> +          with the same priority.
> +      -
> +        name: ifindex
> +        type: u32
> +        doc: Interface index owning the specified shaper.
> +      -
> +        name: parent
> +        type: nest
> +        nested-attributes: handle
> +        doc: |
> +          Identifier for the parent of the affected shaper.
> +          Only needed for @group operation.
> +      -
> +        name: leaves
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: leaf-info
> +        doc: |
> +           Describes a set of leaves shapers for a @group operation.
> +  -
> +    name: handle
> +    attributes:
> +      -
> +        name: scope
> +        type: u32
> +        enum: scope
> +        doc: Defines the shaper @id interpretation.
> +      -
> +        name: id
> +        type: u32
> +        doc: |
> +          Numeric identifier of a shaper. The id semantic depends on
> +          the scope. For @queue scope it's the queue id and for @node
> +          scope it's the node identifier.
> +  -
> +    name: leaf-info
> +    subset-of: net-shaper
> +    attributes:
> +      -
> +        name: handle
> +      -
> +        name: priority
> +      -
> +        name: weight
> +
> +operations:
> +  list:
> +    -
> +      name: get
> +      doc: |
> +        Get information about a shaper for a given device.
> +      attribute-set: net-shaper
> +
> +      do:
> +        pre: net-shaper-nl-pre-doit
> +        post: net-shaper-nl-post-doit
> +        request:
> +          attributes: &ns-binding
> +            - ifindex
> +            - handle
> +        reply:
> +          attributes: &ns-attrs
> +            - ifindex
> +            - parent
> +            - handle
> +            - metric
> +            - bw-min
> +            - bw-max
> +            - burst
> +            - priority
> +            - weight
> +
> +      dump:
> +        pre: net-shaper-nl-pre-dumpit
> +        post: net-shaper-nl-post-dumpit
> +        request:
> +          attributes:
> +            - ifindex
> +        reply:
> +          attributes: *ns-attrs
> +    -
> +      name: set
> +      doc: |
> +        Create or update the specified shaper.
> +        The set operation can't be used to create a @node scope shaper,
> +        use the @group operation instead.
> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]
> +
> +      do:
> +        pre: net-shaper-nl-pre-doit
> +        post: net-shaper-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - handle
> +            - metric
> +            - bw-min
> +            - bw-max
> +            - burst
> +            - priority
> +            - weight
> +
> +    -
> +      name: delete
> +      doc: |
> +        Clear (remove) the specified shaper. When deleting
> +        a @node shaper, reattach all the node's leaves to the
> +        deleted node's parent.
> +        If, after the removal, the parent shaper has no more
> +        leaves and the parent shaper scope is @node, the parent
> +        node is deleted, recursively.
> +        When deleting a @queue shaper or a @netdev shaper,
> +        the shaper disappears from the hierarchy, but the
> +        queue/device can still send traffic: it has an implicit
> +        node with infinite bandwidth. Queue's implicit node

Maybe: The queue’s implicit node …

> +        feeds an implicit RR node at the root of the hierarchy.
> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]
> +
> +      do:
> +        pre: net-shaper-nl-pre-doit
> +        post: net-shaper-nl-post-doit
> +        request:
> +          attributes: *ns-binding
> +
> +    -
> +      name: group
> +      doc: |
> +        Create or update a scheduling group, attaching the specified
> +        @leaves shapers under the specified node identified by @handle,
> +        creating the latter, if needed.
> +        The @leaves shapers scope must be @queue and the node shaper
> +        scope must be either @node or @netdev.
> +        When the node shaper has @node scope, if the @handle @id is not
> +        specified, a new shaper of such scope is created, otherwise the
> +        specified node must already exist.
> +        The @parent handle for the node shaper is optional in most cases.
> +        For newly created node scope shaper, the node parent is set by
> +        default to the parent linked to the @leaves before the @group
> +        operation. If, prior to the grouping operation, the @leaves
> +        have different parents, the node shaper @parent must be explicitly
> +        set.
> +        The user can optionally provide shaping attributes for the node
> +        shaper.
> +        The operation is atomic, on failure no change is applied to
> +        the device shaping configuration, otherwise the @node shaper
> +        full identifier, comprising @binding and @handle, is provided
> +        as the reply.
> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]
> +
> +      do:
> +        pre: net-shaper-nl-pre-doit
> +        post: net-shaper-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - parent
> +            - handle
> +            - metric
> +            - bw-min
> +            - bw-max
> +            - burst
> +            - priority
> +            - weight
> +            - leaves
> +        reply:
> +          attributes: *ns-binding
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca1469d52076..e3d95488d61c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15915,6 +15915,7 @@ F:	include/linux/platform_data/wiznet.h
>   F:	include/uapi/linux/cn_proc.h
>   F:	include/uapi/linux/ethtool_netlink.h
>   F:	include/uapi/linux/if_*
> +F:	include/uapi/linux/net_shaper.h
>   F:	include/uapi/linux/netdev*
>   F:	tools/testing/selftests/drivers/net/
>   X:	Documentation/devicetree/bindings/net/bluetooth/
> diff --git a/include/uapi/linux/net_shaper.h b/include/uapi/linux/net_shaper.h
> new file mode 100644
> index 000000000000..9e3fa63618ee
> --- /dev/null
> +++ b/include/uapi/linux/net_shaper.h
> @@ -0,0 +1,78 @@
> +/* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause) */
> +/* Do not edit directly, auto-generated from: */
> +/*	Documentation/netlink/specs/net_shaper.yaml */
> +/* YNL-GEN uapi header */
> +
> +#ifndef _UAPI_LINUX_NET_SHAPER_H
> +#define _UAPI_LINUX_NET_SHAPER_H
> +
> +#define NET_SHAPER_FAMILY_NAME		"net-shaper"
> +#define NET_SHAPER_FAMILY_VERSION	1
> +
> +/**
> + * enum net_shaper_scope - Defines the shaper @id interpretation.
> + * @NET_SHAPER_SCOPE_UNSPEC: The scope is not specified.
> + * @NET_SHAPER_SCOPE_NETDEV: The main shaper for the given network device.
> + * @NET_SHAPER_SCOPE_QUEUE: The shaper is attached to the given device queue,
> + *   the @id represents the queue number.
> + * @NET_SHAPER_SCOPE_NODE: The shaper allows grouping of queues or other node
> + *   shapers; can be nested in either @netdev shapers or other @node shapers,
> + *   allowing placement in any location of the scheduling tree, except leaves
> + *   and root.
> + */
> +enum net_shaper_scope {
> +	NET_SHAPER_SCOPE_UNSPEC,
> +	NET_SHAPER_SCOPE_NETDEV,
> +	NET_SHAPER_SCOPE_QUEUE,
> +	NET_SHAPER_SCOPE_NODE,
> +
> +	/* private: */
> +	__NET_SHAPER_SCOPE_MAX,
> +	NET_SHAPER_SCOPE_MAX = (__NET_SHAPER_SCOPE_MAX - 1)
> +};
> +
> +/**
> + * enum net_shaper_metric - Different metric supported by the shaper.
> + * @NET_SHAPER_METRIC_BPS: Shaper operates on a bits per second basis.
> + * @NET_SHAPER_METRIC_PPS: Shaper operates on a packets per second basis.
> + */
> +enum net_shaper_metric {
> +	NET_SHAPER_METRIC_BPS,
> +	NET_SHAPER_METRIC_PPS,
> +};
> +
> +enum {
> +	NET_SHAPER_A_HANDLE = 1,
> +	NET_SHAPER_A_METRIC,
> +	NET_SHAPER_A_BW_MIN,
> +	NET_SHAPER_A_BW_MAX,
> +	NET_SHAPER_A_BURST,
> +	NET_SHAPER_A_PRIORITY,
> +	NET_SHAPER_A_WEIGHT,
> +	NET_SHAPER_A_IFINDEX,
> +	NET_SHAPER_A_PARENT,
> +	NET_SHAPER_A_LEAVES,
> +
> +	__NET_SHAPER_A_MAX,
> +	NET_SHAPER_A_MAX = (__NET_SHAPER_A_MAX - 1)
> +};
> +
> +enum {
> +	NET_SHAPER_A_HANDLE_SCOPE = 1,
> +	NET_SHAPER_A_HANDLE_ID,
> +
> +	__NET_SHAPER_A_HANDLE_MAX,
> +	NET_SHAPER_A_HANDLE_MAX = (__NET_SHAPER_A_HANDLE_MAX - 1)
> +};
> +
> +enum {
> +	NET_SHAPER_CMD_GET = 1,
> +	NET_SHAPER_CMD_SET,
> +	NET_SHAPER_CMD_DELETE,
> +	NET_SHAPER_CMD_GROUP,
> +
> +	__NET_SHAPER_CMD_MAX,
> +	NET_SHAPER_CMD_MAX = (__NET_SHAPER_CMD_MAX - 1)
> +};
> +
> +#endif /* _UAPI_LINUX_NET_SHAPER_H */
> diff --git a/net/Kconfig b/net/Kconfig
> index d27d0deac0bf..31fccfed04f7 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -66,6 +66,9 @@ config SKB_DECRYPTED
>   config SKB_EXTENSIONS
>   	bool
>   
> +config NET_SHAPER
> +	bool

It’d be great if you added a help text/description.

[…]


Kind regards,

Paul

