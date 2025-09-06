Return-Path: <netdev+bounces-220585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE534B46FEC
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564ED7C5B8D
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 14:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9BD219A7A;
	Sat,  6 Sep 2025 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IibiyyiR"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6D11CFBA;
	Sat,  6 Sep 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757168000; cv=none; b=WSQpOpKEmDDOR35eqt40Gsd/0D1dwrPtLlldPTju/xCAOdU5d+bwcnXhH1+O6mPA+sJlkENsQHH7igbU7pwiGEkxC7p67ttaON/GiR/BekE59eREpnUPUQ+qhj+cgglDZplnNd9ae+M301dpoFoIShy8w/j+Q2lCtTJ3t8UJTlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757168000; c=relaxed/simple;
	bh=SUTg28ZJsRkSXTT3PgjawxQbv7QSVrlXljA/sqN5les=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fNMc5ZOpDCFFQWv0GkMJnSCtUOAu6Bq/9S66tRVwD/sTmgUJ3XDzt9tsnQk1Yi9pGAnxgbkynOdImnxoG36b4VS/lRRzod5pOT+th/hK6QERaLFOwcUsIUhpvRa+uCzXzd3r5Tjl5Yif3cuBydWyR553a6wzKtTxogE4Jz/K9c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IibiyyiR; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757167994;
	bh=SUTg28ZJsRkSXTT3PgjawxQbv7QSVrlXljA/sqN5les=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IibiyyiR36CqAMePCOPEGLevQFe4TV1rnLOTwQc4XOsn988+RmVBF5Upac97jh2AK
	 OJ4ifamAu3cgvY2fpNBaifPxEJUZHe2bCI2/UH4L2zVyOi9yMyxFCRG/WCw++y4Wiu
	 /6+0vjg2WhTjt6bCDwCJegj9rQM/B6oIjOW569jTWgYTMOYXMA1tXc9XYHEIkJEk1C
	 d29e4y5ccZhhIo488E+YV1HSAsTpmh5LFgp61nWlqQxo2TJ/sVpFy79+SK0kAS0syK
	 P502Zmb1/WbAuLT1u+sSTYs4roXmNHEDiz24xhccECrXoLdVmZVJhO4zCCFOVHwc+X
	 1Ru5Jx8/yXGtw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 76DCB6000C;
	Sat,  6 Sep 2025 14:13:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 880A7201BC9;
	Sat, 06 Sep 2025 14:13:01 +0000 (UTC)
Message-ID: <6e31a9e0-5450-4b45-a557-2aa08d23c25a@fiberby.net>
Date: Sat, 6 Sep 2025 14:13:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 02/11] tools: ynl-gen: generate nested array
 policies
To: Jacob Keller <jacob.e.keller@intel.com>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>
References: <20250904-wg-ynl-prep@fiberby.net>
 <20250904220156.1006541-2-ast@fiberby.net>
 <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <e24f5baf-7085-4db0-aaad-5318555988b3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

CC: Johannes

On 9/6/25 12:19 AM, Jacob Keller wrote:
> On 9/4/2025 3:01 PM, Asbjørn Sloth Tønnesen wrote:
>> This patch adds support for NLA_POLICY_NESTED_ARRAY() policies.
>>
>> Example spec (from future wireguard.yaml):
>> -
>>    name: wgpeer
>>    attributes:
>>      -
>>        name: allowedips
>>        type: indexed-array
>>        sub-type: nest
>>        nested-attributes: wgallowedip
>>
>> yields NLA_POLICY_NESTED_ARRAY(wireguard_wgallowedip_nl_policy).
>>
>> This doesn't change any currently generated code, as it isn't
>> used in any specs currently used for generating code.
>>
>> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
>> ---
> 
> Is this keyed of off the sub-type? Does you mean that all the existing
> uses of 'sub-type: nest' don't generate code today? Or that this
> _attr_policy implementation is not called yet?

Thanks for the reviews. Yeah, it is a careful wording, because we have
specs matching it, but there aren't any source files that triggers
ynl-gen to generate code based on those specs.

Therefore this patch, doesn't result in any code changes when running:
$ ./tools/net/ynl/ynl-regen.sh -f

Actually ynl-gen generates a fictive "{ .type = NLA_INDEXED_ARRAY, }"
policy, without this patch, leading to a build failure.

> I checked and we have quite a number of uses:
> 
>> $ rg 'sub-type: nest'
>> Documentation/netlink/specs/nlctrl.yaml
 >> [..]
>> Documentation/netlink/specs/tc.yaml
>> [..]
>> Documentation/netlink/specs/rt-link.yaml
>> [..]
>> Documentation/netlink/specs/nl80211.yaml
>> [..]

None of those currently have a generated netlink policy.

These are the netlink policies currently generated by ynl-gen:
$ git grep -h -B1 'YNL-GEN kernel source' | grep '^/\*[^ ]'
/*      Documentation/netlink/specs/dpll.yaml */
/*      Documentation/netlink/specs/ovpn.yaml */
/*      Documentation/netlink/specs/team.yaml */
/*      Documentation/netlink/specs/lockd.yaml */
/*      Documentation/netlink/specs/nfsd.yaml */
/*      Documentation/netlink/specs/netdev.yaml */
/*      Documentation/netlink/specs/devlink.yaml */
/*      Documentation/netlink/specs/handshake.yaml */
/*      Documentation/netlink/specs/fou.yaml */
/*      Documentation/netlink/specs/mptcp_pm.yaml */
/*      Documentation/netlink/specs/net_shaper.yaml */

Johannes introduced NLA_NESTED_ARRAY and the NLA_POLICY_NESTED_ARRAY()
macro in commit 1501d13596b9 for use in nl80211, and it's therefore
used in net/wireless/nl80211.c, but outside of that the macro is
only sparsely adopted (only by mac80211_hwsim.c and nf_tables_api.c).

Wireguard adopts the macro in this RFC patch:
https://lore.kernel.org/netdev/20250904220255.1006675-2-ast@fiberby.net/

