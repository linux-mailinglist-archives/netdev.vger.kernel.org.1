Return-Path: <netdev+bounces-272020-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMcIKIImxWkU7QQAu9opvQ
	(envelope-from <netdev+bounces-272020-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F913352E2
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 13:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F39983063D68
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C494E38656A;
	Thu, 26 Mar 2026 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdiI7vh2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A185726982C
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774527562; cv=none; b=hGiPKCMqi4kNvysXbh0tdSWk9xHK3qYTDLOV5tiUbez143cHR0R1ioUEVa5ho3chconKrfRM2IVd8QD8fyWlKoN8+lKEIy+KUZHQyjIclfa7ioKtQNYS10mNndZlzW+osbuPohAr3G39qz1cktSI43/Cpyp7U6o4XD4+MgKYu/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774527562; c=relaxed/simple;
	bh=cxS4l1tkVK5CASnfRSmVTqevqOKI5ZREyGT5b/+/820=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vam/rrcpcuMFZ9YDoAbjO6ATXNbbc4KBNDmg8hE2TaSyTKaaq4i1+pzCbtkwNMzm0gJQt6NOewL0q6nnIEqyAvQr+a2HRK7jCNGbO1roEGFBgdXf+aQJ9fqIOZinQWF7zyM9/QjF/HWPL2cdQuoTW6gRa6PB1mYMkvlO9HVEYnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdiI7vh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA97C116C6;
	Thu, 26 Mar 2026 12:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774527562;
	bh=cxS4l1tkVK5CASnfRSmVTqevqOKI5ZREyGT5b/+/820=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XdiI7vh2QpQr85a4TgeXPIFMHrJLEmfOYd1rbiJsDbcNT4JUYC+/jW7hrZJV/5t0r
	 SMvA6Pge9TaIF571t2m9lQKwIpmlCmH/+XqG6RfGSwFhbwtawGdPQI8QY0pXVks9uJ
	 EDu/FH7ked/xOcRkcY/zT+K4rw222HYvlNK9/K+uzVe80Qjvk/L1pkyAEYrQaVNcP/
	 ug3lLvA7FrVNI1TjXZfM+q2x4FurNPX2AqGZnVkjF7IihGtp5DNYE4FdkYX/dtLwCz
	 AcdiHw+QCJh5MkgPl9QqGuxfK/9paERgOQ4/x6L+f+vLUBM4uNhcArJdP64M3LyEpO
	 G0nBxM9eeP3eg==
Message-ID: <f1263c70-ef11-4622-93bf-a5f5acaf735c@kernel.org>
Date: Thu, 26 Mar 2026 13:19:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests: net: add veth BQL stress test
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, j.koeppeler@tu-berlin.de, kernel-team@cloudflare.com
References: <20260324174719.1224337-1-hawk@kernel.org>
 <20260324174719.1224337-7-hawk@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260324174719.1224337-7-hawk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272020-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: F2F913352E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 24/03/2026 18.47, hawk@kernel.org wrote:
> From: Jesper Dangaard Brouer<hawk@kernel.org>
> 
> Add a selftest that exercises veth's BQL (Byte Queue Limits) code path
> under sustained UDP load. The test creates a veth pair with GRO enabled
> (activating the NAPI path and BQL), attaches a qdisc, optionally loads
> iptables rules in the consumer namespace to slow NAPI processing, and
> floods UDP packets for a configurable duration.
> 
[...]
> 
> Signed-off-by: Jesper Dangaard Brouer<hawk@kernel.org>
> Tested-by: Jonas Köppeler<j.koeppeler@tu-berlin.de>
> ---
>   tools/testing/selftests/net/veth_bql_test.sh  | 784 ++++++++++++++++++
>   .../selftests/net/veth_bql_test_virtme.sh     | 124 +++
>   2 files changed, 908 insertions(+)
>   create mode 100755 tools/testing/selftests/net/veth_bql_test.sh
>   create mode 100755 tools/testing/selftests/net/veth_bql_test_virtme.sh
> 
> diff --git a/tools/testing/selftests/net/veth_bql_test.sh b/tools/testing/selftests/net/veth_bql_test.sh
> new file mode 100755
> index 000000000000..9b5923341040
> --- /dev/null
> +++ b/tools/testing/selftests/net/veth_bql_test.sh

The netdev/shellcheck [0][1] had some review comments.
I will work on addressing these.

[0] 
https://netdev-ctrl.bots.linux.dev/logs/build/1071815/14493217/shellcheck/stdout
[1] https://www.shellcheck.net/

pw-bot: changes-requested

--Jesper

