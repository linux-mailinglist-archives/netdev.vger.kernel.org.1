Return-Path: <netdev+bounces-78195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07A88744F8
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 01:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E41F1C22292
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265AB1848;
	Thu,  7 Mar 2024 00:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XBSgwuyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39E21847
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769900; cv=none; b=ANIZaGk3ELe5zZgj8ix49WQI/OJpExtSwrGfAugr+YyrRd+GkTaSJ5yG1WIVgyjcIl/ZPS54P4LgdL9zWnlGU/HHWxoJqU8gB8i/SdMZJ+VlOClrDFdO49lY+4eUu2GofCXv/+pYB10qFpFy4ZMYxXtpUEBmh7f4C+hQ450hvgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769900; c=relaxed/simple;
	bh=s+t/Cm0wIX7rMQXlybCJ0qw4TTpMaTxYylKKjaY6NMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H40onzLYhBCRzvG3mx/MYE640XayRLRFGqdQ1kxCbPiTNgcSt5Aw7yn/AIcSplF9FU04C1S+5fGZbHNSASAYgglJEG60sPhL3zAxXIbUgH7w0z5rXnPHVY7fzw27Y2sn0FjEE6xSR9Uof/bkae5M8uAszu2+wdhIcBTa6TLFgWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XBSgwuyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E54C433C7;
	Thu,  7 Mar 2024 00:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709769899;
	bh=s+t/Cm0wIX7rMQXlybCJ0qw4TTpMaTxYylKKjaY6NMI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XBSgwuyVkK0BoMxa1Aeyhtp8nzxtY7PbpUE8i41wzbm8aLjktK7nAsx7UsYFPuFbK
	 zsDCvtY5n/ITvnG5v/7JZe+cnZoRntGLV/CyJs3AytLOcmrpdcKD2TC9EtAJyx27L1
	 +PSX0+RyrFDs91RtoAH4J1+qr02hEHICEQuFlOwvO53I/IIslaUduvpoIYtKWLqGYT
	 FRhs0PRMD3okVMa7CFnn+QZy0QhEX8IG/tvSI6bKIr1sLqCkrBEpsyrytCnfncxW4x
	 PdGRncgOI3BXct52vqmi9dSS3wepK1lVzBGVFIOMo3LMySB3hdQatMbyPYmNiInuzc
	 J8rWVS9fzNFZw==
Date: Wed, 6 Mar 2024 16:04:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 5/5] doc/netlink/specs: Add spec for nlctrl
 netlink family
Message-ID: <20240306160458.3605e8aa@kernel.org>
In-Reply-To: <CAD4GDZwtD7v_zQzeGDu93sropHbRsRANUMJ-MAB1w+CZCMyXuQ@mail.gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-6-donald.hunter@gmail.com>
	<20240306103114.41a1cfb4@kernel.org>
	<CAD4GDZwtD7v_zQzeGDu93sropHbRsRANUMJ-MAB1w+CZCMyXuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 22:54:08 +0000 Donald Hunter wrote:
> > I've used
> >         enum-name:
> > i.e. empty value in other places.
> > Is using empty string more idiomatic?  
> 
> I got this when I tried to use an empty value, so I used '' everywhere instead.
> 
> jsonschema.exceptions.ValidationError: None is not of type 'string'
> 
> Failed validating 'type' in
> schema['properties']['attribute-sets']['items']['properties']['enum-name']:
>     {'description': 'Name for the enum type of the attribute.',
>      'type': 'string'}
> 
> On instance['attribute-sets'][1]['enum-name']:
>     None
> 
> It turns out that the fix for that is a schema change:
> 
> --- a/Documentation/netlink/genetlink-legacy.yaml
> +++ b/Documentation/netlink/genetlink-legacy.yaml
> @@ -169,7 +169,7 @@ properties:
>            type: string
>          enum-name:
>            description: Name for the enum type of the attribute.
> -          type: string
> +          type: [ string, "null" ]
>          doc:
>            description: Documentation of the space.
>            type: string
> 
> I'll respin with a cleaned up nlctrl spec and fixes for the schemas.

Hm, is this some new version of jsonschema perhaps?
We use empty values all over the place:

$ git grep 'enum-name:$' -- Documentation/netlink/specs/
Documentation/netlink/specs/ethtool.yaml:    enum-name:
Documentation/netlink/specs/fou.yaml:    enum-name:
Documentation/netlink/specs/ovs_datapath.yaml:    enum-name:
Documentation/netlink/specs/ovs_flow.yaml:    enum-name:
Documentation/netlink/specs/ovs_flow.yaml:    enum-name:

