Return-Path: <netdev+bounces-82336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835888D526
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 04:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A81B229B8
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 03:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC323765;
	Wed, 27 Mar 2024 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUVZ1MrY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE823758
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 03:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511172; cv=none; b=Kn45TpXXCFdLTLqVnBhPyYVNQu/PXA2o94iHlwmJDXHIn5Rk58x9IkpzOKLnRtUgqbSdcTWp80rpLW3EK5HUc66jzAgE6x8LTJLW6Oin/v/x2GKShw9DzTgQXiL/gV5BeMfMVzk5g31A0IQ+cCJjGkuRhZP9dp59Co4k+l6KOus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511172; c=relaxed/simple;
	bh=PsMRKldHY8lBJ1yi1FQf4Mflo79dKGUMIK/YvwwLzSc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3o6kFqAM28GC9KEIWG8yNjdxjlxgEaZ54GUfo8nBDjfrWp85Yjh4SxttwfJN8k6j4srs20Fk6wrj9ggBLembpmtcP8+SY5dJL1DBF1vOkYqozPff7aRu4zGhVic9ODBVG9x1TSd94XKwbyrXdLNnYKkqpFClx4cM7C/rvCtwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUVZ1MrY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A016C43390;
	Wed, 27 Mar 2024 03:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711511172;
	bh=PsMRKldHY8lBJ1yi1FQf4Mflo79dKGUMIK/YvwwLzSc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUVZ1MrYhTMvGvS1DCOEwdnasAB1AtRWqtIudM4YxSftKIrqWs7w5YSfa2A/a6pFR
	 0N4NFYnVJ2pYod27Z7RBOtQtcNJoDiUUOO5wpBCnTrXL0Z0Wkz6Zc8j2zo0y5/ncjf
	 05obcx+GafqzSgrD/2ODlqPlyP+odTDuFxZtS1GQGxQMP3H8alXaMy3mhJTHVZoxw8
	 ARWrHG2dK9vfTsHIBv8xTc5MDwKUBn9p851jyPuM9tCMcxjF66K/RIMxIrrQU2e1nt
	 zty5P8GvdZQNSfAQPnK+//lPZB/FKX43w3hgC5FJuHwNOcdIt5R56UlmfuCvpIu1zC
	 m2ePaTnXyOGtQ==
Date: Tue, 26 Mar 2024 20:46:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Donald
 Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jacob
 Keller <jacob.e.keller@intel.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next 1/2] ynl: rename array-nest to indexed-array
Message-ID: <20240326204610.1cb1715b@kernel.org>
In-Reply-To: <20240326063728.2369353-2-liuhangbin@gmail.com>
References: <20240326063728.2369353-1-liuhangbin@gmail.com>
	<20240326063728.2369353-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 14:37:27 +0800 Hangbin Liu wrote:
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 5fa7957f6e0f..7239e673a28a 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -686,8 +686,9 @@ class YnlFamily(SpecFamily):
>                  decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
>                  if 'enum' in attr_spec:
>                      decoded = self._decode_enum(decoded, attr_spec)
> -            elif attr_spec["type"] == 'array-nest':
> -                decoded = self._decode_array_nest(attr, attr_spec)
> +            elif attr_spec["type"] == 'indexed-array' and 'sub-type' in attr_spec:
> +                if attr_spec["sub-type"] == 'nest':
> +                    decoded = self._decode_array_nest(attr, attr_spec)

We need to make sure somehow cleanly that we treat unknown subtype the
same we would treat unknown type. In this elif ladder we have:

            else:
                if not self.process_unknown:
                    raise Exception(f'Unknown {attr_spec["type"]} with name {attr_spec["name"]}')

So we should raise an exception if sub-type != nest.

>              elif attr_spec["type"] == 'bitfield32':
>                  value, selector = struct.unpack("II", attr.raw)
>                  if 'enum' in attr_spec:
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 6b7eb2d2aaf1..8d5ec5449648 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -838,8 +838,9 @@ class AttrSet(SpecAttrSet):
>              t = TypeBitfield32(self.family, self, elem, value)
>          elif elem['type'] == 'nest':
>              t = TypeNest(self.family, self, elem, value)
> -        elif elem['type'] == 'array-nest':
> -            t = TypeArrayNest(self.family, self, elem, value)
> +        elif elem['type'] == 'indexed-array' and 'sub-type' in elem:
> +            if elem["sub-type"] == 'nest':
> +                t = TypeArrayNest(self.family, self, elem, value)

same here

>          elif elem['type'] == 'nest-type-value':
>              t = TypeNestTypeValue(self.family, self, elem, value)
>          else:
> @@ -1052,8 +1053,9 @@ class Family(SpecFamily):
>                      if nested in self.root_sets:
>                          raise Exception("Inheriting members to a space used as root not supported")
>                      inherit.update(set(spec['type-value']))
> -                elif spec['type'] == 'array-nest':
> -                    inherit.add('idx')
> +                elif spec['type'] == 'indexed-array' and 'sub-type' in spec:
> +                    if spec["sub-type"] == 'nest':
> +                        inherit.add('idx')

Here you don't have to match on sub-type, all indexed-arrays will have
an idx (index) member.

>                  self.pure_nested_structs[nested].set_inherited(inherit)
>  
>          for root_set, rs_members in self.root_sets.items():
> @@ -1616,9 +1618,10 @@ def _multi_parse(ri, struct, init_lines, local_vars):
>      multi_attrs = set()
>      needs_parg = False
>      for arg, aspec in struct.member_list():
> -        if aspec['type'] == 'array-nest':
> -            local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
> -            array_nests.add(arg)
> +        if aspec['type'] == 'indexed-array' and 'sub-type' in aspec:
> +            if aspec["sub-type"] == 'nest':
> +                local_vars.append(f'const struct nlattr *attr_{aspec.c_name};')
> +                array_nests.add(arg)

Please also update the info about nested-array in
Documentation/userspace-api/netlink/genetlink-legacy.rst
-- 
pw-bot: cr

