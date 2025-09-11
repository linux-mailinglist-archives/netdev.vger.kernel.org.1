Return-Path: <netdev+bounces-221900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362EB524E3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 02:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE1E1C84491
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD44DDD2;
	Thu, 11 Sep 2025 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="VGcVaBXn"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F0748F;
	Thu, 11 Sep 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757548920; cv=none; b=sLc7+H5tkY0uqTV1nqIEfzt77IfQnSDEERXsL0oGA9aJhwyKFXUkJV3Dxn5z3NasgnE728wipv1RwTjZge/WBsHqi0A0I3BHjYz+E68GqL8GTuYDnkVHWkgRaKiCODI4mprabUs344tUO5fYEQzBOR99h7o66vtLv+lnKQvwioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757548920; c=relaxed/simple;
	bh=hcPnMipU2xqeVVWkjAP2fKprVNClO0nQS9RLP+GCumk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efLGDEmu/jo8q2yTbTsbjiCXh8g/+9fjWzl2zlPOOoakaMvvm+FKhCIkoBU7qkBfyR9M3q2QrFHjOZ+xi487egW09ztHOHKcnVzu0nsDY+p6cz3Q6dpYD4iwXOfConIoqDd5+b/uUQ+H/yxU+Ptkino82apMiqg6Q1KMC+cKqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=VGcVaBXn; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757548915;
	bh=hcPnMipU2xqeVVWkjAP2fKprVNClO0nQS9RLP+GCumk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VGcVaBXnbMBS5Aq7c37tqFGeHyRyrIxBUmXQQ04+cwqej6MYGPoDJmZ4gTMP9jA4H
	 fls++6Ivu6BsQHF5Zyc9FffCbdYugrf/w8IxzTvFhdKZFudv9Xyr58cupp5U3Sml++
	 zBbhVZRQN4vTuyIzfkc3jozO0tsStW27onFnyzKWNqnIZBEhUFp8djorMwBDhdflxH
	 flbKMfYRzr0t4ge/YB0vKxPKwqDVwhQ74m+ogHDjb740HW+eH6NObDVojxBa7Qzaha
	 VKOfn/oiIEjNCdIddhFyFEZ2PAnUB4XEGnJ6kBb/+lTPMz7mA01Y+QJAFTWbeafz+x
	 bmPLX9Rz985QA==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DA8066000C;
	Thu, 11 Sep 2025 00:01:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 01FCC201AFC;
	Thu, 11 Sep 2025 00:01:48 +0000 (UTC)
Message-ID: <3b52386e-6127-4bdc-b7db-e3c885b03f72@fiberby.net>
Date: Thu, 11 Sep 2025 00:01:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/11] tools: ynl-gen: define nlattr *array in a
 block scope
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Simon Horman <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-5-ast@fiberby.net>
 <20250905171809.694562c6@kernel.org>
 <4eda9c57-bde0-43c3-b8a0-3e45f2e672ac@fiberby.net>
 <20250906120754.7b90c718@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <20250906120754.7b90c718@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/6/25 7:07 PM, Jakub Kicinski wrote:
> On Sat, 6 Sep 2025 13:13:29 +0000 Asbjørn Sloth Tønnesen wrote:
>> In patch 4, it is about a variable used by multiple Type classes having
>> presence_type() = 'count', which is currently 3 classes:
>> - TypeBinaryScalarArray
>> - TypeMultiAttr
>> - TypeArrayNest (later renamed to TypeIndexedArray)
>>
>> In patch 5, I move code for a special variable used by one Type class,
>> to be contained within that class. It makes it easier to ensure that the
>> variable is only defined, when used, and vice versa. This comes at the
>> cost of the generated code looking generated.
> 
> So you're agreeing?
> 
>> If we should make the generated code look like it was written by humans,
>> then I would move the definition of these local variables into a class
>> method, so `i` can be generated by the generic implementation, and `array`
>> can be implemented in it's class. I will take a stab at this, but it might
>> be too much refactoring for this series, eg. `len` is also defined local
>> to conditional blocks multiple branches in a row.
>>
>> tools/net/ynl/generated/nl80211-user.c:
>> nl80211_iftype_data_attrs_parse(..) {
>>     [..]
>>     ynl_attr_for_each_nested(attr, nested) {
>>       unsigned int type = ynl_attr_type(attr);
>>
>>       if (type == NL80211_BAND_IFTYPE_ATTR_IFTYPES) {
>>         unsigned int len;
>>         [..]
>>       } else if (type == NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC) {
>>         unsigned int len;
>>         [..]
>>       [same pattern 8 times, so 11 times in total]
>>       } else if (type == NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE) {
>>         unsigned int len;
>>         [..]
>>       }
>>     }
>>     return 0;
>> }
> 
> It's pretty easily doable, I already gave up on not calling _attr_get()
> for sub-messages.
> 
>> That looks very generated, I would have `len` defined together with `type`,
>> and a switch statement would also look a lot more natural, but maybe leave
>> the if->switch conversion for the compiler to detect.
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index fb7e03805a11..8a1f8a477566 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -243,7 +243,7 @@ from lib import SpecSubMessage, SpecSubMessageFormat
>           raise Exception(f"Attr get not implemented for class type {self.type}")
>   
>       def attr_get(self, ri, var, first):
> -        lines, init_lines, local_vars = self._attr_get(ri, var)
> +        lines, init_lines, _ = self._attr_get(ri, var)
>           if type(lines) is str:
>               lines = [lines]
>           if type(init_lines) is str:
> @@ -251,10 +251,6 @@ from lib import SpecSubMessage, SpecSubMessageFormat
>   
>           kw = 'if' if first else 'else if'
>           ri.cw.block_start(line=f"{kw} (type == {self.enum_name})")
> -        if local_vars:
> -            for local in local_vars:
> -                ri.cw.p(local)
> -            ri.cw.nl()
>   
>           if not self.is_multi_val():
>               ri.cw.p("if (ynl_attr_validate(yarg, attr))")
> @@ -2101,6 +2097,7 @@ _C_KW = {
>               else:
>                   raise Exception(f"Per-op fixed header not supported, yet")
>   
> +    var_set = set()
>       array_nests = set()
>       multi_attrs = set()
>       needs_parg = False
> @@ -2118,6 +2115,13 @@ _C_KW = {
>               multi_attrs.add(arg)
>           needs_parg |= 'nested-attributes' in aspec
>           needs_parg |= 'sub-message' in aspec
> +
> +        try:
> +            _, _, l_vars = aspec._attr_get(ri, '')
> +            var_set |= set(l_vars) if l_vars else set()
> +        except:
> +            pass  # _attr_get() not implemented by simple types, ignore
> +    local_vars += list(var_set)
>       if array_nests or multi_attrs:
>           local_vars.append('int i;')
>       if needs_parg:
I left this for you to submit, there is a trivial conflict with patch 8
in my v2 posting.

It gives a pretty nice diffstat when comparing the generated code:

  devlink-user.c      |  187 +++----------------
  dpll-user.c         |   10 -
  ethtool-user.c      |   49 +----
  fou-user.c          |    5
  handshake-user.c    |    3
  mptcp_pm-user.c     |    3
  nfsd-user.c         |   16 -
  nl80211-user.c      |  159 +---------------
  nlctrl-user.c       |   21 --
  ovpn-user.c         |    7
  ovs_datapath-user.c |    9
  ovs_flow-user.c     |   89 ---------
  ovs_vport-user.c    |    7
  rt-addr-user.c      |   14 -
  rt-link-user.c      |  183 ++----------------
  rt-neigh-user.c     |   14 -
  rt-route-user.c     |   26 --
  rt-rule-user.c      |   11 -
  tc-user.c           |  380 +++++----------------------------------
  tcp_metrics-user.c  |    7
  team-user.c         |    5
  21 files changed, 175 insertions(+), 1030 deletions(-)

