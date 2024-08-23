Return-Path: <netdev+bounces-121207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B0D95C2F8
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 03:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BC51F2348C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDBF17997;
	Fri, 23 Aug 2024 01:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P70mCoNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734101D68F
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377707; cv=none; b=Ve2Xcjk4n0lDd20ELJHBKh3DdPc6P3t9jvhjeWryNiv0Hdu2xa814RgGz0ZlZAbiroUrXgoGDFmRlTS83Es15dvV8nTF0wzflJf3qXqQZvLon11MqLv/Ob5/QC7kJiT+c9dti55/sbkK4bBxh2PllYVZXvKWxr3KOCSMJZuPnbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377707; c=relaxed/simple;
	bh=jDFl1Tu15odMSjoaLkLEa77Eg38FVOhFqSsSmC+NHuE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcaBjcv468mV/m1fgYt2c5d4bsQSwozangshkmVdNxDsxXXuiSfqMIfhtdfTHjWpgh1W74FbsydlT4tEOColn+wfRpAFsLFv2RrMDIw8pMMqq0Os/by5Y+T3SiEYx95rrHhAcNO9exZMR4uXoRoE6S6a4qirahvust6kresjsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P70mCoNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB67C4AF0B;
	Fri, 23 Aug 2024 01:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724377706;
	bh=jDFl1Tu15odMSjoaLkLEa77Eg38FVOhFqSsSmC+NHuE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P70mCoNkJwXvwLbiCpW1ot5VnK715JrHDKi9aLlVPp/4IC74DpxYU0QHtGFNO5wSr
	 m7x/iB14olfHpgH8ktZPgNaimvesVwnrErV8NIzi7y4PCF+T+eZSrp90ZsxJ814CQB
	 Lcu+H/b7Eo+pLKcv9WiSdq7Egs+1cUoLXppNGeS1qGAD/cT7PMAe3lLuwK9wxaVqUU
	 QWJ6rU9IGbaT8VsVIi6o2yWIWq5O3lDfQJ4QNV5ysH+E0yVBR6V6vWgyIrqytsb2M2
	 y8+DPiQQSoWaLR6JlowycNdJ0OVaiCcL5eFkiiLVr2bsRO9dOxnjvfCKS+NvGROoG+
	 uRFlpw+4Gsf8g==
Date: Thu, 22 Aug 2024 18:48:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH v4 net-next 02/12] netlink: spec: add shaper YAML spec
Message-ID: <20240822184824.3f0c5a28@kernel.org>
In-Reply-To: <dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
References: <cover.1724165948.git.pabeni@redhat.com>
	<dac4964232855be1444971d260dab0c106c86c26.1724165948.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 17:12:23 +0200 Paolo Abeni wrote:
> diff --git a/Documentation/netlink/specs/net_shaper.yaml b/Documentation/netlink/specs/net_shaper.yaml
> new file mode 100644
> index 000000000000..a2b7900646ae
> --- /dev/null
> +++ b/Documentation/netlink/specs/net_shaper.yaml
> @@ -0,0 +1,289 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +
> +name: net-shaper
> +
> +doc: |
> +  Network device HW rate limiting configuration.
> +
> +  This API allows configuring HR shapers available on the network

What's HR?

> +  device at different levels (queues, network device) and allows
> +  arbitrary manipulation of the scheduling tree of the involved
> +  shapers.
> +
> +  Each @shaper is identified within the given device, by an @handle,
> +  comprising both a @scope and an @id, and can be created via two
> +  different modifiers: the @set operation, to create and update single

s/different modifiers/operations/

> +  shaper, and the @group operation, to create and update a scheduling
> +  group.
> +
> +  Existing shapers can be deleted via the @delete operation.

deleted -> deleted / reset

> +  The user can query the running configuration via the @get operation.

The distinction between "scoped" nodes which can be "set"
and "detached" "node"s which can only be created via "group" (AFAIU)
needs clearer explanation.

> +definitions:
> +  -
> +    type: enum
> +    name: scope
> +    doc: The different scopes where a shaper can be attached.

Are they attached or are they the nodes themselves?
Maybe just say that scope defines the ID interpretation and that's it.

> +    render-max: true
> +    entries:
> +      - name: unspec
> +        doc: The scope is not specified.
> +      -
> +        name: netdev
> +        doc: The main shaper for the given network device.
> +      -
> +        name: queue
> +        doc: The shaper is attached to the given device queue.
> +      -
> +        name: node
> +        doc: |
> +             The shaper allows grouping of queues or others
> +             node shapers, is not attached to any user-visible

Saying it's not attached is confusing. Makes it sound like it exists
outside of the scope of a struct net_device.

> +             network device component, and can be nested to
> +             either @netdev shapers or other @node shapers.

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
> +        name: info
> +        type: nest
> +        nested-attributes: info
> +        doc: Fully describes the shaper.
> +      -
> +        name: metric
> +        type: u32
> +        enum: metric
> +        doc: Metric used by the given shaper for bw-min, bw-max and burst.
> +      -
> +        name: bw-min
> +        type: uint
> +        doc: Minimum guaranteed B/W for the given shaper.

s/Minimum g/G/
Please spell out "bandwidth" in user-facing docs.

> +      -
> +        name: bw-max
> +        type: uint
> +        doc: Shaping B/W for the given shaper or 0 when unlimited.

s/Shaping/Maximum/

> +      -
> +        name: burst
> +        type: uint
> +        doc: Maximum burst-size for bw-min and bw-max.

How about:

s/bw-min and bw-max/shaping. Should not be interpreted as a quantum./

?

> +      -
> +        name: priority
> +        type: u32
> +        doc: Scheduling priority for the given shaper.

Please clarify that that priority is only valid on children of 
a scheduling node, and the priority values are only compared
between siblings.

> +      -
> +        name: weight
> +        type: u32
> +        doc: |
> +          Weighted round robin weight for given shaper.

Relative weight of the input into a round robin node.

?

> +          The scheduling is applied to all the sibling
> +          shapers with the same priority.
> +      -
> +        name: scope
> +        type: u32
> +        enum: scope
> +        doc: The given shaper scope.

:)

> +      -
> +        name: id
> +        type: u32
> +        doc: |
> +          The given shaper id. 

"Numeric identifier of a shaper."

Do we ever use ID and scope directly in a nest with other attrs?
Or are they always wrapped in handle/parent ?
If they are always wrapped they can be a standalone attr set / space.

> The id semantic depends on the actual
> +          scope, e.g. for @queue scope it's the queue id, for
> +          @node scope it's the node identifier.
> +      -
> +        name: ifindex
> +        type: u32
> +        doc: Interface index owning the specified shaper.
> +      -
> +        name: parent
> +        type: nest
> +        nested-attributes: handle
> +        doc: |
> +          Identifier for the parent of the affected shaper,
> +          The parent is usually implied by the shaper handle itself,
> +          with the only exception of the root shaper in the @group operation.

Maybe just say that specifying the parent is only needed for group
operations? I think that's what you mean.

> +      -
> +        name: leaves
> +        type: nest
> +        multi-attr: true
> +        nested-attributes: info
> +        doc: |
> +           Describes a set of leaves shapers for a @group operation.
> +      -
> +        name: root
> +        type: nest
> +        nested-attributes: root-info
> +        doc: |
> +           Describes the root shaper for a @group operation

missing full stop

> +           Differently from @leaves and @shaper allow specifying
> +           the shaper parent handle, too.

Maybe this attr is better called "node", after all.

> +      -
> +        name: shaper
> +        type: nest
> +        nested-attributes: info
> +        doc: |
> +           Describes a single shaper for a @set operation.

Hm. How is this different than "info"?

$ git grep SHAPER_A_INFO
include/uapi/linux/net_shaper.h:        NET_SHAPER_A_INFO,
$

is "info" supposed to be used?

> +operations:
> +  list:
> +    -
> +      name: get
> +      doc: |
> +        Get / Dump information about a/all the shaper for a given device.

There's no need to "/ dump" and "/all".

> +      attribute-set: net-shaper

> +    -
> +      name: set
> +      doc: |
> +        Create or updates the specified shaper.

create or update

> +        On failure the extack is set accordingly.

it better be - no need to explain netlink basics

> +        Can't create @node scope shaper, use
> +        the @group operation instead.

"The set operation can't be used to create a @node scope shaper..."

> +      attribute-set: net-shaper
> +      flags: [ admin-perm ]
> +
> +      do:
> +        pre: net-shaper-nl-pre-doit
> +        post: net-shaper-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - shaper
> +
> +    -
> +      name: delete
> +      doc: |
> +        Clear (remove) the specified shaper. When deleting
> +        a @node shaper, relink all the node's leaves to the

relink -> reattach ?

> +        deleted node parent.

delete node's parent

> +        If, after the removal, the parent shaper has no more
> +        leaves and the parent shaper scope is @node, even
> +        the parent node is deleted, recursively.
> +        On failure the extack is set accordingly.
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
> +        Creates or updates a scheduling group, adding the specified

Please use imperative mood, like in a commit message.

adding -> attach(ing)

> +++ b/net/shaper/Makefile
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the Generic HANDSHAKE service
> +#
> +# Copyright (c) 2024, Red Hat, Inc.

Ironic that you added the copyright given the copy/paste 
fail in the contents... ;)

