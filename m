Return-Path: <netdev+bounces-82695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C6488F438
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 01:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90B71F2E1FB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 00:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F314E210EC;
	Thu, 28 Mar 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/UmYXjD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54F208B0
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 00:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711586852; cv=none; b=AdnvlXIW4C8k/4Gonfz/haRa174d2sY61YSCesVLGlsM6Osn0P8l0Iw4iNkYPfECz+uFltDGNtphEG/oIZdGswZi+1Y58S5qzdGGGNKrDOid6uGNtSo0tpv+8fHD1+NDqlkNkE3H3MpgYNVZ5u8Tyqpt1LQD6HzXI4yl7AuqSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711586852; c=relaxed/simple;
	bh=/3e5j1pZT5R4ZLPVlNBdoGzSUNkZCcCp1sMuHOs/UkE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9bRbgRAAR/F0D1lbW8SAzUJTfVIrK6ZuDBXwvZvL5CLpzjSxZdyIJyaEOm96mohjXs+zkuuRDr7lcaA3n4+/D5DmT7nul5SzQCHH1GjFm1zUmN3EIHicgbMSPcLAvNl9Y/6YHgo5WUhFsnc03W+eXwvZ5H/+Y4g4I+2t+oMBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/UmYXjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F5DC433F1;
	Thu, 28 Mar 2024 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586852;
	bh=/3e5j1pZT5R4ZLPVlNBdoGzSUNkZCcCp1sMuHOs/UkE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o/UmYXjDsv1kfRCol3jHvZc2ht3Iyt8mXwYol9PkflMv8XCgT0NmBiA6Gw03DuWcx
	 Ka0riY2U43/52eACCiMZ06hol65sTxqH2UNtwFDyIvPXx2fr/g84EncxeUBB2sJ0Od
	 JJAybHmXJB+jKAoWWSZ99LBCeGhX4Tlqy7el7Gg/ZAfqhVnJ9H8lIuR39crejGZqPE
	 WZ1JmhRCY2dcNJ1ceqXH24IhESx6gKd5pnJQ9mMJOEIMNRb5oN/Ru3aX+11Zpv7Yh0
	 9KfNWsAqaO6MeItMOGypSXU5bCVn0VNIhjDdYjb0qRXBdSbdYsYwCPWPCbkIKUpaKD
	 zYQkns/fZDqvA==
Date: Wed, 27 Mar 2024 17:47:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1] tools/net/ynl: Add extack policy attribute
 decoding
Message-ID: <20240327174731.6933ed21@kernel.org>
In-Reply-To: <20240327160302.69378-1-donald.hunter@gmail.com>
References: <20240327160302.69378-1-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 16:03:02 +0000 Donald Hunter wrote:
> The NLMSGERR_ATTR_POLICY extack attribute has been ignored by ynl up to
> now. Extend extack decoding to include _POLICY and the nested
> NL_POLICY_TYPE_ATTR_* attributes.
> 
> For example:
> 
> ./tools/net/ynl/cli.py \
>   --spec Documentation/netlink/specs/rt_link.yaml \
>   --create --do newlink --json '{
>     "ifname": "12345678901234567890",
>     "linkinfo": {"kind": "bridge"}
>     }'
> Netlink error: Numerical result out of range
> nl_len = 104 (88) nl_flags = 0x300 nl_type = 2
> 	error: -34	extack: {'msg': 'Attribute failed policy validation',
> 'policy': {'max-length': 15, 'type': 'string'}, 'bad-attr': '.ifname'}

Nice!

Some optional comments below...

> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 5fa7957f6e0f..557ef5a22b7d 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>  
>  from collections import namedtuple
> +from enum import Enum
>  import functools
>  import os
>  import random
> @@ -76,6 +77,25 @@ class Netlink:
>      NLMSGERR_ATTR_MISS_TYPE = 5
>      NLMSGERR_ATTR_MISS_NEST = 6
>  
> +    # Policy types
> +    NL_POLICY_TYPE_ATTR_TYPE = 1
> +    NL_POLICY_TYPE_ATTR_MIN_VALUE_S = 2
> +    NL_POLICY_TYPE_ATTR_MAX_VALUE_S = 3
> +    NL_POLICY_TYPE_ATTR_MIN_VALUE_U = 4
> +    NL_POLICY_TYPE_ATTR_MAX_VALUE_U = 5
> +    NL_POLICY_TYPE_ATTR_MIN_LENGTH = 6
> +    NL_POLICY_TYPE_ATTR_MAX_LENGTH = 7
> +    NL_POLICY_TYPE_ATTR_POLICY_IDX = 8
> +    NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE = 9
> +    NL_POLICY_TYPE_ATTR_BITFIELD32_MASK = 10
> +    NL_POLICY_TYPE_ATTR_PAD = 11
> +    NL_POLICY_TYPE_ATTR_MASK = 12
> +
> +    AttrType = Enum('AttrType', ['flag', 'u8', 'u16', 'u32', 'u64',
> +                                  's8', 's16', 's32', 's64',
> +                                  'binary', 'string', 'nul-string',
> +                                  'nested', 'nested-array',
> +                                  'bitfield32', 'sint', 'uint'])
>  
>  class NlError(Exception):
>    def __init__(self, nl_msg):
> @@ -198,6 +218,8 @@ class NlMsg:
>                      self.extack['miss-nest'] = extack.as_scalar('u32')
>                  elif extack.type == Netlink.NLMSGERR_ATTR_OFFS:
>                      self.extack['bad-attr-offs'] = extack.as_scalar('u32')
> +                elif extack.type == Netlink.NLMSGERR_ATTR_POLICY:
> +                    self.extack['policy'] = self._decode_policy(extack.raw)
>                  else:
>                      if 'unknown' not in self.extack:
>                          self.extack['unknown'] = []
> @@ -214,6 +236,34 @@ class NlMsg:
>                              desc += f" ({spec['doc']})"
>                          self.extack['miss-type'] = desc
>  
> +    def _decode_policy(self, raw):
> +        policy = {}
> +        for attr in NlAttrs(raw):
> +            if attr.type == Netlink.NL_POLICY_TYPE_ATTR_TYPE:
> +                type = attr.as_scalar('u32')
> +                policy['type'] = Netlink.AttrType(type).name
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_S:
> +                policy['min-value-s'] = attr.as_scalar('s64')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_S:
> +                policy['max-value-s'] = attr.as_scalar('s64')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_VALUE_U:
> +                policy['min-value-u'] = attr.as_scalar('u64')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_VALUE_U:
> +                policy['max-value-u'] = attr.as_scalar('u64')

I think the signed / unsigned thing is primarily so that decode knows
if its s64 or u64. Is it useful for the person seeing the decoded
extack whether max was signed or unsigned?

IOW are we losing any useful info if we stop the -u / -s suffixes?

Otherwise I'd vote lose them.

> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MIN_LENGTH:
> +                policy['min-length'] = attr.as_scalar('u32')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MAX_LENGTH:
> +                policy['max-length'] = attr.as_scalar('u32')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_IDX:
> +                policy['policy-idx'] = attr.as_scalar('u32')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_POLICY_MAXTYPE:
> +                policy['policy-maxtype'] = attr.as_scalar('u32')

I don't think these two (policy-..) can actually pop up in extack.
They are for cross-referencing nested policies in policy dumps.
extack only carries constraints local to the attr.

Up to you if you want to keep them.

> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_BITFIELD32_MASK:
> +                policy['bitfield32-mask'] = attr.as_scalar('u32')
> +            elif attr.type == Netlink.NL_POLICY_TYPE_ATTR_MASK:
> +                policy['mask'] = attr.as_scalar('u64')
> +        return policy
> +
>      def cmd(self):
>          return self.nl_type
>  


