Return-Path: <netdev+bounces-288124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kObDEE5nBmrOjQIAu9opvQ
	(envelope-from <netdev+bounces-288124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F101547F88
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87A4530237D8
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5D12192FA;
	Fri, 15 May 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM3KpllV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5921771B;
	Fri, 15 May 2026 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804479; cv=none; b=Gw8kSbWGiA24zpGDYA2yFnPAs0ibdHAp7IWd0vTx0yiG6JdTF66JM6A7wTNLHssKT9wqrWPv7t4Nr4ulvp1gZ0jEKUN+YUKFmHMxa90EEvKuDV1EFyyXSF1Njs8GgGFWa3sqQxOKzfrmjDiopzxl8OHTmpvJtx5c6u1wmcHwfjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804479; c=relaxed/simple;
	bh=ZTvOd0uB1Ju0Md2Nb3++sx3rRD8bpVqiedLSDvIKz8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j2yoLUpWsu5xaiHNO76maU2Gyt5Gbsz+w1gyxZ4f7mlihT+hsQptzApMQhS/kZxhYeIAjF5egmoSaGQRh3qo1mNtUQTjcgBAYpkxEsPKGJh4NkSbf5Ru3kUP79opoq+MZjKvDAHoQeohpXh6yBUvxJFrohecRxEHLypfK33/Ow4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM3KpllV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5B0C2BCB3;
	Fri, 15 May 2026 00:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778804479;
	bh=ZTvOd0uB1Ju0Md2Nb3++sx3rRD8bpVqiedLSDvIKz8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XM3KpllV60Mgh6wILoy66Uv2izQg8jgiip/bC0OUOBRKLH/oylBzlpskXis03NTd5
	 YVQUyv/pQznbY5+B+OZ4VjPS7Y0Kq0bosVpenAZd2muX1p3WAZBnPSL3EMLmN+Z7kq
	 AD5sVEwcew0tzXDjNwHeC6h3xLPE4z1k7k5dY+McBQPjMVA5CMVsgY5uCSbAtRM2n4
	 iHGhlC+g2vxmfWRsN8jl7Q66JEdFqRyTDsM+/iNEdOCaMAZdJZu+wW9tzGyRAOGj1S
	 5Zq9rdZ3ri2IcI7e1BUYMZoXj2wqkCO/qaXVuJmjsDRNFHdAMAxkOZOZG76mgBCXaD
	 N0Ct7sxMPhPdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 058F839E4DB3;
	Fri, 15 May 2026 00:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v10 1/2] selftests: openvswitch: add vlan() and
 encap() flow string parsing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880442379.134878.9953459778629075808.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 00:20:23 +0000
References: <20260512070841.1183581-2-houminxi@gmail.com>
In-Reply-To: <20260512070841.1183581-2-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org
X-Rspamd-Queue-Id: 3F101547F88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288124-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 May 2026 15:08:40 +0800 you wrote:
> Add VLAN TCI formatting and parsing support to ovs-dpctl.py:
> 
> - Add _vlan_dpstr() to decompose TCI into vid/pcp/cfi fields,
>   with raw tci=0x%04x fallback when cfi=0 for round-trip safety.
> - Add _parse_vlan_from_flowstr() boundary check for missing ')'.
> - Add encap_ovskey subclass restricting nla_map to L2-L4 attributes
>   (slots 0-21) that appear inside 802.1Q ENCAP, with metadata
>   attributes set to "none".
> - Check encap parse() return value for unrecognized trailing content.
> - Support callable format functions in dpstr() output.
> - Change OVS_KEY_ATTR_VLAN type from uint16 to be16 to match the
>   kernel __be16 wire format; uint16 decodes in host byte order,
>   which gives wrong values on little-endian architectures.
> - Change OVS_KEY_ATTR_ENCAP type from none to encap_ovskey to
>   enable recursive parsing of 802.1Q encapsulated flow keys.
> - Add push_vlan action class with fields matching kernel struct
>   ovs_action_push_vlan (vlan_tpid, vlan_tci as network-order u16).
> - Add push_vlan dpstr format and parse with range validation
>   (vid 0-4095, pcp 0-7, tpid 0-0xFFFF) and CFI forced to 1.
> 
> [...]

Here is the summary with links:
  - [net-next,v10,1/2] selftests: openvswitch: add vlan() and encap() flow string parsing
    https://git.kernel.org/netdev/net-next/c/db30e412b7f5
  - [net-next,v10,2/2] selftests: openvswitch: add pop_vlan test
    https://git.kernel.org/netdev/net-next/c/2476e005b13a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



