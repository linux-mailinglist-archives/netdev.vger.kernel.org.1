Return-Path: <netdev+bounces-95661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D978C2F1A
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 04:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D91283310
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 02:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ECC1DDE9;
	Sat, 11 May 2024 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ellYEkRS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B17D8462;
	Sat, 11 May 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715395234; cv=none; b=EVS+gJdtmzKDY3DZFWDZ9p226qcmsSFcJtt4mv2bbo/EJWp4ZRyEiadEBk/rduPNkL632b0jRpikrca4jDD3rpqVpKH9E4bEToMd0H/SMOmqPctY47bhUsW1JWyjBpYK9QeJBy/Dy+G89GGRDpVAN+6n7zHO/B+t+WcL4vi1T9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715395234; c=relaxed/simple;
	bh=7/s6vD+y/7k4WVPD7xgH8TVamYoeEI7TfVwC3jGXrcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mWThPIbMUaCL25gSYc8nspqDo3jmApCyG8kIcOuvUYvbFyVC8kqUlcSqeuzjum1/FileJaH1PnncMgFM5pWkzEGeot+VnqJW/PYSIOlr52kjYe7ea1yACCh8JXnptECn+gY724sR/qryzoWzrRHs+ea2Y5swKwEjY8Szpis5C/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ellYEkRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FD26C2BD10;
	Sat, 11 May 2024 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715395233;
	bh=7/s6vD+y/7k4WVPD7xgH8TVamYoeEI7TfVwC3jGXrcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ellYEkRSAxRyQuDc2UBhjpC+3+6d2L7iSIegIk+kBsJp7GRF7Pp4Iwzg5pI+77Gna
	 oJfeMsq3ku7uLqSeCUc1qrz/E4RzsCplqoRWD/0ivw6/5HhOxzE9dUJWdFLiudFhW1
	 8h+DMF01bcFZ2bhC2lbVmvJ1QxNjfgr4BohlNPh05UwK60DpOXnm6XAuZuNAQ+ifZ4
	 k7fZ6ZDE5YJJrIiJXV0p7eIjXGfysQnd01dhJwJa/B6uBCh8bbYBu+jtgKlFLU39Zf
	 Njvhekx0WP1tNZvEfVuk1nej1dV/nKj6axIb0H+Wazx3UBWs0GM5/Mzm9uuD3WZWNL
	 Gdn19t3D0Ds3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F63FE7C114;
	Sat, 11 May 2024 02:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/14] net: qede: convert filter code to use
 extack
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171539523345.2430.17083493506076122601.git-patchwork-notify@kernel.org>
Date: Sat, 11 May 2024 02:40:33 +0000
References: <20240508143404.95901-1-ast@fiberby.net>
In-Reply-To: <20240508143404.95901-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, manishc@marvell.com,
 przemyslaw.kitszel@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 14:33:48 +0000 you wrote:
> This series converts the filter code in the qede driver
> to use NL_SET_ERR_MSG_*(extack, ...) for error handling.
> 
> Patch 1-12 converts qede_parse_flow_attr() to use extack,
> along with all it's static helper functions.
> 
> qede_parse_flow_attr() is used in two places:
> - qede_add_tc_flower_fltr()
> - qede_flow_spec_to_rule()
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/14] net: qede: use extack in qede_flow_parse_ports()
    https://git.kernel.org/netdev/net-next/c/a7c9540e967b
  - [net-next,v2,02/14] net: qede: use extack in qede_set_v6_tuple_to_profile()
    https://git.kernel.org/netdev/net-next/c/6f88f1257a40
  - [net-next,v2,03/14] net: qede: use extack in qede_set_v4_tuple_to_profile()
    https://git.kernel.org/netdev/net-next/c/f63a9dc507f9
  - [net-next,v2,04/14] net: qede: use extack in qede_flow_parse_v6_common()
    https://git.kernel.org/netdev/net-next/c/a62944d11ae1
  - [net-next,v2,05/14] net: qede: use extack in qede_flow_parse_v4_common()
    https://git.kernel.org/netdev/net-next/c/f2f993835b26
  - [net-next,v2,06/14] net: qede: use extack in qede_flow_parse_tcp_v6()
    https://git.kernel.org/netdev/net-next/c/b1a18d5781d4
  - [net-next,v2,07/14] net: qede: use extack in qede_flow_parse_tcp_v4()
    https://git.kernel.org/netdev/net-next/c/f84d52776ccf
  - [net-next,v2,08/14] net: qede: use extack in qede_flow_parse_udp_v6()
    https://git.kernel.org/netdev/net-next/c/b73ad5c7a72e
  - [net-next,v2,09/14] net: qede: use extack in qede_flow_parse_udp_v4()
    https://git.kernel.org/netdev/net-next/c/9c8f5ed8849c
  - [net-next,v2,10/14] net: qede: add extack in qede_add_tc_flower_fltr()
    https://git.kernel.org/netdev/net-next/c/f833a6555e9e
  - [net-next,v2,11/14] net: qede: use extack in qede_parse_flow_attr()
    https://git.kernel.org/netdev/net-next/c/d6883bceb254
  - [net-next,v2,12/14] net: qede: use faked extack in qede_flow_spec_to_rule()
    https://git.kernel.org/netdev/net-next/c/eb705d734525
  - [net-next,v2,13/14] net: qede: propagate extack through qede_flow_spec_validate()
    https://git.kernel.org/netdev/net-next/c/d2a437efd017
  - [net-next,v2,14/14] net: qede: use extack in qede_parse_actions()
    https://git.kernel.org/netdev/net-next/c/841548793bd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



