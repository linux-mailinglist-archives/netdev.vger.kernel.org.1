Return-Path: <netdev+bounces-187574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2117BAA7DF4
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 03:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E485A648E
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261E170838;
	Sat,  3 May 2025 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP8SYZE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005023CB
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 01:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746236629; cv=none; b=Y1yUjZx6lDNmNUKpix0aYEnPb2V+NXZEjkXfS+mb/S7S2/h51d7LvnhG4L8OX3kIxieIE4Y7f6fS+ddP3glQ4kxgQEZXtMUwU1BSMiGnUhlJQEVWg2TT1OSebBYi1GPBD4Kk3RuPQszEYToU8+Tn+LmhKmOM8cYKCMUUeO9tdwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746236629; c=relaxed/simple;
	bh=flqQIFwsklfokXaym6bHikq2Fj04IG6su38j+DpFmQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eymyNa36wGZFm4LYItuUtJlPIxPGSLBc10fqQ2GGzQMru2zhpONNAMJMQo+9mYJld+rLmPEH2StB/FIO/HMuB70NU/We147Ao4IQoO4eCPSENffNt+UJlkXP8iTkWSvEVbCHTK9xTr/gHkUeqIgLTlHAPQHSBGM2JhOAeIXf9RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP8SYZE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F26DC4CEE4;
	Sat,  3 May 2025 01:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746236628;
	bh=flqQIFwsklfokXaym6bHikq2Fj04IG6su38j+DpFmQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YP8SYZE8U1f9tVITmWuOmJ4D+rgxhvq+QtF2ht/KUUH6crc9yEHotepdmazUK5/+e
	 jx1JGQHiVBfceu3GV73KUJdDt6m4NWaeurgIJZelMOJU2uIdOK8Q3LV51mG64iyh6E
	 n6qyaJXy8sGAyFBHIjUOYkudd/AXMWxiIHr6HPaYaVtzLiGTA4LWrf3YO36dqy7LYP
	 KO02xo90iZFkchCqODK8F65VhE53qfvF32Fjb2y1wwCe9a0lXRctpwJOuBKD+I8/tw
	 t/nsAF22ujf2QecZJPQCCRnViYEddv3Sjtcihswk090jwgrPfd3lDRzEND/f7FiAd9
	 mNoM/mi/pOi/Q==
Date: Fri, 2 May 2025 18:43:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next 2/5] tools: ynl-gen: allow noncontiguous enums
Message-ID: <20250502184347.68488470@kernel.org>
In-Reply-To: <20250502113821.889-3-jiri@resnulli.us>
References: <20250502113821.889-1-jiri@resnulli.us>
	<20250502113821.889-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 May 2025 13:38:18 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> In case the enum has holes, instead of hard stop, generate a validation
> callback to check valid enum values.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> Saeed's v3->v1:
> - add validation callback generation
> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 45 +++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index b4889974f645..c37551473923 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -358,11 +358,13 @@ class TypeScalar(Type):
>          if 'enum' in self.attr:
>              enum = self.family.consts[self.attr['enum']]
>              low, high = enum.value_range()
> -            if 'min' not in self.checks:
> +            if low and 'min' not in self.checks:
>                  if low != 0 or self.type[0] == 's':
>                      self.checks['min'] = low
> -            if 'max' not in self.checks:
> +            if high and 'max' not in self.checks:
>                  self.checks['max'] = high
> +            if not low and not high:
> +                self.checks['sparse'] = True

you should probably explicitly check for None, 0 is a valid low / high
  
>          if 'min' in self.checks and 'max' in self.checks:
>              if self.get_limit('min') > self.get_limit('max'):

> +def print_kernel_policy_sparse_enum_validates(family, cw):
> +    first = True
> +    for _, attr_set in family.attr_sets.items():
> +        if attr_set.subset_of:
> +            continue
> +
> +        for _, attr in attr_set.items():
> +            if not attr.request:
> +                continue
> +            if not attr.enum_name:
> +                continue
> +            if 'sparse' not in attr.checks:
> +                continue
> +
> +            if first:
> +                cw.p('/* Sparse enums validation callbacks */')
> +                first = False
> +
> +            sign = '' if attr.type[0] == 'u' else '_signed'
> +            suffix = 'ULL' if attr.type[0] == 'u' else 'LL'
> +            cw.write_func_prot('static int', f'{c_lower(attr.enum_name)}_validate',
> +                               ['const struct nlattr *attr', 'struct netlink_ext_ack *extack'])
> +            cw.block_start()
> +            cw.block_start(line=f'switch (nla_get_{attr["type"]}(attr))', noind=True)
> +            enum = family.consts[attr['enum']]
> +            for entry in enum.entries.values():
> +                cw.p(f'case {entry.c_name}: return 0;')

All the cases end in "return 0;"
remove this, and add the return 0; before the block end.
The code should look something like:

	switch (nla_get_...) {
	case VAL1:
	case VAL2:
	case VAL3:
		return 0;
	}

> +            cw.block_end(noind=True)
> +            cw.p('NL_SET_ERR_MSG_ATTR(extack, attr, "invalid enum value");')
> +            cw.p('return -EINVAL;')
> +            cw.block_end()
> +            cw.nl()
> +
> +
>  def print_kernel_op_table_fwd(family, cw, terminate):
>      exported = not kernel_can_gen_family_struct(family)
>  
> @@ -2965,6 +3003,7 @@ def main():
>              print_kernel_family_struct_hdr(parsed, cw)
>          else:
>              print_kernel_policy_ranges(parsed, cw)
> +            print_kernel_policy_sparse_enum_validates(parsed, cw)
>  
>              for _, struct in sorted(parsed.pure_nested_structs.items()):
>                  if struct.request:


