Return-Path: <netdev+bounces-66467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63283F57F
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 13:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DBD283138
	for <lists+netdev@lfdr.de>; Sun, 28 Jan 2024 12:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7E01E884;
	Sun, 28 Jan 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DoOsqjuQ"
X-Original-To: netdev@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237BD210F2
	for <netdev@vger.kernel.org>; Sun, 28 Jan 2024 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706445312; cv=none; b=Ho1b/AI0WSsDDCHdRNFBuzSoJVM+fqCJVUQflg9gdxuwq4qyCxXj2CI9d5L9bKaVBBorVLq3ehWK2SgRK4Vvpw6x6BEWRRRc18jIlyx+vOJxA3lO2uLuE2ZOmOoZ/F+Q0qbhFs3JSlwchZGneNUzX8FNNOPLnBxoKVmQyuJu5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706445312; c=relaxed/simple;
	bh=235h4BEOqyTuoeLPsjBKoYZ1qvynA8GqDq9T7lGs49E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ59mG/d+ZueCvXhrvgqockp/OhXQZys5Ljk83bJ4oexUzcvElSeQ22ij6DR15RdMfb4LYhi5p+YKLdRRQVC40QeOMEDidoMuSKgErhRqqowW6WrI1qgNNQ+1NfjNCVOmRd9GrkWOz0jr3eyyqJIuP251RtM5V4ikp5+ZfCX8v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DoOsqjuQ; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E25AD3200A7C;
	Sun, 28 Jan 2024 07:35:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 28 Jan 2024 07:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706445308; x=1706531708; bh=A8yfdxkc5LJDjdzO6XU529bgC5ry
	RdJzvslQkbmN4LI=; b=DoOsqjuQjh+k4MKEFgZ1Gnvmg3dDmCOi1ZEcegA96d5D
	cLUwuerhcJhONj7SvPvPWWVSmYqv1WePCMJHQX4EPZiqgCcWB3wBHXQ7tUzfu5VL
	6g7U7dhgGKA5Ntdtaqkx0misnmVb6VTKVG8NuNj1/x0wr0YlTVgnKUvqXViqZ1Aq
	aqhNgCbSHxw0Xj3fY76PikxnwnFgZPB35VHG9L3Mrua5OmxtajjOyDAeIxxvJi24
	kxLRY72j7iGXsggDMzQoDRK4A/CrwHcDkVRdcdIUQB+//Ldmt+DSgplJlztkqz7/
	JyNxrZmC/BGv9+wfVx3CKi0c983OiWltJ0+PGe9v5g==
X-ME-Sender: <xms:_Em2ZTgRe9kXpyD7D__krPFbUQXJfAiTuS-3d6IhCmaCzH-V7epyLA>
    <xme:_Em2ZQDBdOJeAXroil5h7_xHG2sjp2ajXFoaZNlXTngHm0-3-IxyNgm94rQwv8RFs
    7tQOZNfReY72gE>
X-ME-Received: <xmr:_Em2ZTGFfDQktdpB3wmxwaJSt2w4geWT9vqVeYf5ylk_Q9l7H-ZAU8mRPR85>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtvddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:_Em2ZQQovsR3ZbEe7kVc4Cdq0Yj4U_Nttbo7WwdQu8Ex4TY33pqmYw>
    <xmx:_Em2ZQxm3jSVl4ALHnGnK8Ap10MkAIUcrHavk1W8ikdnE5VSewCmAg>
    <xmx:_Em2ZW7XVk4UabIJPIdih9cpOq1TaTT0G7V_8JYduu7tHP64ZUF9DQ>
    <xmx:_Em2Zb-ok-JWlM9aQekvA-BhBnNPJl0KNcCvcHyeXOwazOnWkjt_-g>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Jan 2024 07:35:07 -0500 (EST)
Date: Sun, 28 Jan 2024 14:35:04 +0200
From: Ido Schimmel <idosch@idosch.org>
To: David Ahern <dsahern@gmail.com>
Cc: Vincent Bernat <vincent@bernat.ch>, Alce Lafranque <alce@lafranque.net>,
	netdev@vger.kernel.org, stephen@networkplumber.org
Subject: Re: [PATCH iproute2] vxlan: add support for flowlab inherit
Message-ID: <ZbZJ-IS20fe8wmQv@shredder>
References: <20240120124418.26117-1-alce@lafranque.net>
 <Za5eizfgzl5mwt50@shredder>
 <f24380fc-a346-4c81-ae78-e0828d40836e@gmail.com>
 <1793b6c1-9dba-4794-ae0d-5eda4f6db663@bernat.ch>
 <1fb36101-5a3c-4c81-8271-4002768fa0bd@gmail.com>
 <41582fa0-1330-42c5-b4eb-44f70713e77e@bernat.ch>
 <1e2ff78d-d130-46d4-b7ad-31a0f6796e1a@gmail.com>
 <e60e2cc1-02c0-452b-8bb1-b2fb741e7b43@bernat.ch>
 <fa8e2b04-5ddf-4121-be34-c57690f06c63@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa8e2b04-5ddf-4121-be34-c57690f06c63@gmail.com>

On Fri, Jan 26, 2024 at 10:17:36AM -0700, David Ahern wrote:
> On 1/25/24 11:28 PM, Vincent Bernat wrote:
> > Honestly, I have a hard time finding a real downside. The day we need to
> > specify both a value and a policy, it will still be time to introduce a
> > new keyword. For now, it seems better to be consistent with the other
> > protocols and with the other keywords (ttl, for example) using the same
> > approach.
> 
> ok. let's move forward without the new keyword with the understanding it
> is not perfect, but at least consistent across commands should a problem
> arise. Consistency allows simpler workarounds.

I find it weird that the argument for the current approach is
consistency when the commands are already inconsistent:

1. VXLAN flow label can be specified either in decimal or hex, but the
expectation is decimal according to the help message. ip6gre flow label
can only be configured as hex:

# ip link help vxlan
[...]
        LABEL := 0-1048575

# ip link help ip6gre
[...]
        FLOWLABEL := { 0x0..0xfffff | inherit }

# ip link add name vx0 up type vxlan vni 10010 local 2001:db8:1::1 flowlabel 100 dstport 4789
# ip -d -j -p link show dev vx0 | jq '.[]["linkinfo"]["info_data"]["label"]'
"0x64"

# ip link add name g6 up type ip6gre local 2001:db8:1::1 flowlabel 100
# ip -d -j -p link show dev g6 | jq '.[]["linkinfo"]["info_data"]["flowlabel"]'
"0x00100"

2. The keywords in the JSON output are different as you can see above.
The format of the value is also different.

3. Value of 0 is not printed for VXLAN, but is printed for ip6gre:

# ip link add name vx0 up type vxlan vni 10010 local 2001:db8:1::1 flowlabel 0 dstport 4789
# ip -d -j -p link show dev vx0 | jq '.[]["linkinfo"]["info_data"]["label"]'
null

# ip link add name g6 up type ip6gre local 2001:db8:1::1 flowlabel 0
# ip -d -j -p link show dev g6 | jq '.[]["linkinfo"]["info_data"]["flowlabel"]'
"0x00000"

If you do decide to move forward with the current approach, then at
least the JSON output needs to be modified to print something when
"inherit" is set. With current patch:

# ip link add name vx0 up type vxlan vni 10010 local 2001:db8:1::1 flowlabel inherit dstport 4789
# ip -d -j -p link show dev vx0 | jq '.[]["linkinfo"]["info_data"]["label"]'
null

I would also try to avoid sending the new 'IFLA_VXLAN_LABEL_POLICY' attribute
for existing use cases: When creating a VXLAN device with a fixed flow label or
when simply modifying an already fixed flow label. I would expect kernels
6.5-6.7 to reject the new attribute as since kernel 6.5 the VXLAN driver
enforces strict validation. However, it's not the case:

# uname -r
6.7.0-custom
# ip link help vxlan | grep LABEL | grep inherit
        LABEL   := { 0-1048575 | inherit }
# ip link add name vx0 up type vxlan vni 10010 local 2001:db8:1::1 flowlabel 100 dstport 4789
# echo $?
0

It seems to be an oversight in kernel commit 56738f460841 ("netlink: add strict
parsing for future attributes") which states "Also, for new attributes, we need
not accept them when the policy doesn't declare their usage". I do get a
failure with the following diff [1] (there's probably a nicer way):

# uname -r
6.7.0-custom-dirty
# ip link help vxlan | grep LABEL | grep inherit
        LABEL   := { 0-1048575 | inherit }
# ip link add name vx0 up type vxlan vni 10010 local 2001:db8:1::1 flowlabel 100 dstport 4789
Error: Unknown attribute type.

Regarding the comment about the
"inherit-during-the-day-fixed-during-the-night" policy, I'm familiar
with at least one hardware implementation that supports a policy of
"inherit flow label when IPv6, otherwise set flow label to X" and it
indeed won't be possible to express it with the single keyword approach.

[1]
diff --git a/lib/nlattr.c b/lib/nlattr.c
index dc15e7888fc1..8da3be8a76dd 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -619,7 +619,9 @@ static int __nla_validate_parse(const struct nlattr *head, int len, int maxtype,
                u16 type = nla_type(nla);
 
                if (type == 0 || type > maxtype) {
-                       if (validate & NL_VALIDATE_MAXTYPE) {
+                       if ((validate & NL_VALIDATE_MAXTYPE) ||
+                           (policy && policy[0].strict_start_type &&
+                            type >= policy[0].strict_start_type)) {
                                NL_SET_ERR_MSG_ATTR(extack, nla,
                                                    "Unknown attribute type");
                                return -EINVAL;

