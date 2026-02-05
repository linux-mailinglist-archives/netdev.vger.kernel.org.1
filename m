Return-Path: <netdev+bounces-257251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OF8CH7IhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:42:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96B0F55E6
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A50301BEC3
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9C843637A;
	Thu,  5 Feb 2026 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3XasSvU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0042189D;
	Thu,  5 Feb 2026 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309752; cv=none; b=cJmDu+eNn7CNm7qvYcHiJjFxkwRqLmboN3R5L60eDZjSi9LO2sZN+QhEis7jVkutfHv3fwq00hogwkDY8MKisGBoQ6NbAuq7TsE41vo2NKpvOsfrv5WUwEBqDGay7lOEsVHWPPKvM3fIH0VY2IoL0Z/5d12ZtyNqdKeTWjp83/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309752; c=relaxed/simple;
	bh=klxI1NngqdxTvO7KE093/0ZePpp7ya1iOje/mtcFI0I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Bhgul0fCcRjjRA4mwEjSkpn8ENfTxPmJvJZd+bzwLZ3QBM5j0RtBZdv1H4VMI8ZfKbwudOs42A8S+Z9dY1oETL6M5e6r//RIDpAFyin9TH/xr2QE3A+lsho4syCU8PK6n+1C5JePlRn8ihDLC/0puq2XrWGbEUKkIE8DDNsxv5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3XasSvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31246C4CEF7;
	Thu,  5 Feb 2026 16:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770309751;
	bh=klxI1NngqdxTvO7KE093/0ZePpp7ya1iOje/mtcFI0I=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Z3XasSvUv0vQC7L1AwzIVKvuRL1Kk58Ub2D6NqlglpabuqQ9x/5bjdjrIvj6K8Wby
	 ZhNpF4EOzz+dDM2DGGWkqkC/JaE2kgMRrz/gafDWTqpqQuQIfm+nXGjTtkp5D1rHCe
	 QHQQaKjXNWi2UCtKr4iPsnjNP/d2Rwt//TsS4mgc3HycvdfEKCrN0UoVl8vLta1SND
	 P4WrsYtLewgKUOZW9PlAGrfkuN2nTzm5WXFaAVTz4s/DQF+avqqyF5NqjOTJXZVCcn
	 lXs1UG9wWbgtRtxQCdZvhVesn3GbvUDU/tBd5atVpF3itApbNQDiN1ttjpP3dfGhzJ
	 3aqezAYm5U/Hg==
Date: Thu, 5 Feb 2026 17:42:24 +0100
From: Matthieu Baerts <matttbe@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <e630bf98-05df-4809-9f78-d10abfd075d8@kernel.org>
In-Reply-To: <20260205075606.5b94c492@kernel.org>
References: <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-0-cb559fb6b50a@kernel.org> <20260204-net-mptcp-misc-fixes-6-19-rc8-v1-3-cb559fb6b50a@kernel.org> <f2f5c43d-bf6d-4fe9-9062-1f649d5c276b@kernel.org> <20260205075606.5b94c492@kernel.org>
Subject: Re: [PATCH net 3/4] mptcp: fix kdoc warnings
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <e630bf98-05df-4809-9f78-d10abfd075d8@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257251-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B96B0F55E6
X-Rspamd-Action: no action

Hi Jakub,

05 Feb 2026 16:56:08 Jakub Kicinski <kuba@kernel.org>:

> On Thu, 5 Feb 2026 11:56:39 +0100 Matthieu Baerts wrote:
>>> diff --git a/include/uapi/linux/mptcp_pm.h b/include/uapi/linux/mptcp_p=
m.h
>>> index c97d060ee90b..fe9863d75350 100644
>>> --- a/include/uapi/linux/mptcp_pm.h
>>> +++ b/include/uapi/linux/mptcp_pm.h
>>> @@ -11,7 +11,7 @@
>>> #define MPTCP_PM_VER=C2=A0=C2=A0 1
>>>
>>> /**
>>> - * enum mptcp_event_type
>>> + * enum mptcp_event_type - Netlink MPTCP event types=C2=A0
>>
>> I forgot that this file was auto-generated from a YAML file.
>>
>> Sorry for the noise, I will send a v2 also adapting the YAML file.
>
> Hm, do we need some clever way to teach the codegen about short
> descriptions?

In my case, there was no "doc" for this enum:

=C2=A0 https://lore.kernel.org/20260205-mptcp-fix-kdoc-yml-v1-1-9858c4b7baf=
6@kernel.org

Adding it fixes the kdoc warning.

Do you mean that the codegen should add a short description even if
"doc" is not set?

Cheers,
Matt

