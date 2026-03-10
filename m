Return-Path: <netdev+bounces-265952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNGaKZDhr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:17:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6E7248238
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2148430BF411
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923143D4EA;
	Tue, 10 Mar 2026 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C2RkSwuq"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477F843CEED;
	Tue, 10 Mar 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133690; cv=fail; b=nSYyE49i5vbe6j1D/o4FpBfeGAMk6PJ0MmEqlY2fDDHv2EdR5t1mmXrr0DTSxP22F7BKCpFzEb2dkgxIu/qLLGU9uiZ6zYeonn/3LQ5Dj+MlcSc50Zo8PuR9T9rLEgPP3zP5euK8R5eZ+tR4u/djRHTD0Fmr8Zu/5s+h9mPvvjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133690; c=relaxed/simple;
	bh=FpTDZl764DYCYe8MO8XfzBGT2gG/19FEabaocAfKZjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYjlq5iQGh5V4TLUlWdyultclzu+fyj1Z/n+iwn3QFa1b+SAR5dw44e99PgxzkG9HxYeWmp1gN1P5y01peDnrAFANllYWGC8anhz08tecCPJ/v4frh4FdO0bqoJ646liG1KxNJqisliwh+GofkMW/84DtYNU9zMwkqfvbZLNiOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C2RkSwuq; arc=fail smtp.client-ip=52.101.65.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdPyTd9RUa76a9Kb83xHlTKCjTESsS9sWUNBgN4zzhPNcwzFBfkt3t7wqD3sdaRkX94lhxvuUgJygTZM0bgrXfRgHZ0l3zViNPXQ3mFJsUHoQqKqtk+flgKEvhxzPio6Rl6WI2bJB1qHD7aXQi/bYWdHTNEhWkRivKY6DV0wVAUWxR3bauJFFqbrA9r9nqV3VJA5W7SaslcSKWCoAC42XsDc+YWr+ox6Je083Cq/PifwCe2liYbNs4912IskWgpN6J69e9Q5TI9XMpsPssiM75djr341/4EIlFifrk/CubfccnzhDduaPXIJ7UeUybwT1MyPmmCOnaHCQ9abMPCJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A/LN0/QNqa7kkmB98HsjeVYBVvSEsAzDT3U3GIW9kE=;
 b=cyTY+KqwKcLCgnxUvMth+/F/fSI/5n71SODtG6AWHlVgarA6dPKVq1hQjmbnfsrR/HGb0L+agTBN6Z5ib8ydSXOcQM8LQCUNyHj43l5WBsAaNBeXDREYJVKPuObwSGbTdvYYbrQqb3FXIPoxIItbDaHhN1GrbGZpAB/pwT/t1r8ahUKjqFKNJY9G4BmCgHQDhgXRuaASecXQCEaPsnlb5b8Bo2fjSiReS8rky4PdrviwOBaC5lRJElY/U1EWQMTKM9OCwkSMYgwhl+YrObEMbq7T1KPvTLZpnGFRFZO9lyyTu2cIimXpWSL7ICrhd1EstM/8Iwkn+W3dn4/taqydnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A/LN0/QNqa7kkmB98HsjeVYBVvSEsAzDT3U3GIW9kE=;
 b=C2RkSwuq9iyRuvCyUa5yym/3i2a2zivGeuZjMHmezWq2yKqtVTKZ+KqPYcDZyl+cIDOX3mUa8ubHzsBAJ7sIJ0vliFF4JgrvgtF8NURiMiH1E3f7IoF43QJJON5WnxVKvh+q3V6NEqQP5sdbJMPkryLVKl9sxnCuwXzdtS37wG2LmGN1tSNfcwI3cGfzNEsX2jkxJKPPvo5HCniG/hHzuWnKsOwa07dQnQ2NjYeQtcQ6opPXpH7WqpaXau8E2hzuIYWLEvNT0aVnCrDrHNm/9RkXVIngIAJXuyXu0gtnBeFdw09D805W0xxDkGP3gkSFroq+No19ZUoQUMwoAwfkHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by GVXPR04MB10852.eurprd04.prod.outlook.com (2603:10a6:150:225::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:08:05 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::f010:fca8:7ef:62f4%4]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 09:08:05 +0000
Date: Tue, 10 Mar 2026 11:08:02 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>
Subject: Re: [PATCH] selftests: net: local_termination: test link-local
 protocols
Message-ID: <20260310090802.3fr4i5wkcyeydlio@skbuf>
References: <a085c707b3085eea58850f125c51a8868c5fb6f1.1773072062.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a085c707b3085eea58850f125c51a8868c5fb6f1.1773072062.git.daniel@makrotopia.org>
X-ClientProxiedBy: WA2P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::7) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|GVXPR04MB10852:EE_
X-MS-Office365-Filtering-Correlation-Id: 6356e215-08a6-4923-e956-08de7e848a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	sk/pkMqSF3VTo8mox30ijjzgYlObYa7OAkuqyhOqH3+yhoguYhrFaPW6AZai1VspW3PlqwjX+kBXRsmf0/ldke6NrDpKF/4Wlxzq29rTJRoWVbHc5reoeMfiODkTi/0159y92NL95I4dsfHRVooyVgK/a07d2WXyKquprPt9/VnERvzC+Kiv7gNn3kBrgsT4n8y57i7qCPxKM+gLJCfdubLi1bBSfx/NZzcv8u6QO0ZZZGpqjbIfKQDhxcvTtc2UJCoOuf7jDY+tkN9liLsp3h41ulwR1VhnemcKkg93XH0JhJxB+ZSJb3BkMx9MUjpp4D/KXAmZDRsOy/hrunZaaBcGqqmzH7Motqt0lHMFkEdFjzwzohRe1Yaeaa7qSWTn9vZfrPIlxLm7RZsBPWYMvwyIDpNFnmU65i1uWQQ1zXqli7pU/8JckK59FFRab16JOJbfpyCnOo0J698JgohkF7RY+qv6HvKwZuHcXz/fVp2y8DOtUSZcezSjyez+yIl0FyHPefBQLDPPNYCrl8emQeqgWAjECz7iI3VwupIBc3XCZTjtU+vpYrA0kuWyT/d3+J3qon5YruFfZkl5RWTooBsOW5I7QhNJL4qZYCR5loz7zBKxkfpAI2SIc4mUj7sT3Kh98ZxGHLPcC7kdVFgD1YYkRjgUvw1cYvxag/WOwzqgdVjAoe9Fs2qgh+hWVfvTXR5qXdZ4SXQ/wcmuFnniNDoUkKagINp7mkYbupAjogE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W2sFoBrmbKor+Bk5fi1M9s1F7ZdauYutZGH6GulByi8O0zb3KLiPpDWEnfba?=
 =?us-ascii?Q?VpCH5iP3/4r9iL1Vj5paH++uzjToCIyLEbjJ9eWNkLxMa501lfzoQ5hFfYJO?=
 =?us-ascii?Q?oIwmw/oeFazWNNiJ6Akzw/DqDrorQo/nOw4RpoWwTyheeKWmxnMv1EXMBg1h?=
 =?us-ascii?Q?sIBBBEgDifXJ4ZtImcCh1acQ6TGwDYTdIvrMBmEkg0QmoHjmN5W3DIPedGqZ?=
 =?us-ascii?Q?yiZxK9dml6OSl4pAJ/TUZLbvIBx91G0nbe4VThWjlw1ao4PcbiGpx0RV2wJU?=
 =?us-ascii?Q?zVuCYI+Ma1o+YcIG84ZNY8lDcrTF8/Dfwj6e2Rw6Wh4pTxSEVZPOCECxQhlH?=
 =?us-ascii?Q?Nhm+EhodFpj4LCdaMy/c9XbGZm0DfX2vYyvrQOWbtYMfPaQ7yDOqJkj8O5Ti?=
 =?us-ascii?Q?kAlCMeRFfDskx+FMwOLpkxQok/cHlI1rsZvfyPuvVfA0+Kn+y9x0zRkvhmZS?=
 =?us-ascii?Q?WK+eeTlqC0vPWYkVGECBg6oLAJ3dp3hUHz4WN+5ckTWIixzzezfpXBaSFA6t?=
 =?us-ascii?Q?AKhfizk8pdMCcMr1z15EjNhCG9lgjzxEybqnBZ33gQ988YkRbsxiOPaQZq0G?=
 =?us-ascii?Q?84uObpKUH0iU6e/qJbhMFaUkEhI9AWGRit3F7ilTuiZ23SJFhXs6maSauRHZ?=
 =?us-ascii?Q?8DICqBi+dLP0gvBNQXpiIVioPWVHukDk9HShrvw2rYQhG2VeW4mu9BCGLcgo?=
 =?us-ascii?Q?pHk2i7FQ6D4F6JwEmW/cwKqkEcwYSGWhODj6PwbjvqpEZdM0NPxgY6DBzKE5?=
 =?us-ascii?Q?2Uu/ChJVbPGmsFzpDIhLU8DmZ2yK9RdV4usn1V6fRb0UadEXZ5QeXBcREYRb?=
 =?us-ascii?Q?XDmS8LP5LTtlZVTr7t7A92BIfzbndXKXsWoWwuX8Ls7uDUSvAoLc1g/OTgoP?=
 =?us-ascii?Q?S+dK5uEKP7D5DwOcszzClWpWEuMGfmtGTt0qAwzIwpB7aGm8fzxphu0dXeyR?=
 =?us-ascii?Q?AGurk+PgHRqow25hywjOt3tyzQ/DQrSnCMtoeJc8j7zy1Gi4V5DwVNA/MdRa?=
 =?us-ascii?Q?9VP9EOGhHgCzEZ0zT0OX+hEAAPaPZkKJaUyg88Z6KQc91+hTom+1JcS/fOBy?=
 =?us-ascii?Q?nY30EvKQ/VqGmloxh2464IMCR2wOZvIErPFcIuuzHWKMmlCmChvkHdJ8NBTJ?=
 =?us-ascii?Q?UC6AykoqObp2eXuxsloNCIAtxgjz/k0fccuQN6dROhurpsLsjYSmEntDI21v?=
 =?us-ascii?Q?UJpiRx7CR66lVsfdDA4iIQhSOwtPI+Jl8lXBs+nkCnlquY/8NskuyOYrc6ZX?=
 =?us-ascii?Q?mrisAuAy/2wkaXRLXGnrhg5B0dGwOW76okLJEL8FvReyBh9ZNfF0VwuLsTus?=
 =?us-ascii?Q?ddOdL3c1fg0eJHZi36VdtPSm0KxXr01PvSIkHJsP67YtGOtnpq0CzNP5oCsk?=
 =?us-ascii?Q?skpgpDyJv3BgMFD1suN7yPdgw3d4IJEahtvhCW2oTsen3dyGgZ5/RoNdbIBl?=
 =?us-ascii?Q?j5VDWmE/EoUSqKyCaDut6Ox/k9aAvubdLuyZCRvjXQpHkQytkYs9fZa5Vbtd?=
 =?us-ascii?Q?hJiPg2hQjGHM651l+kdo6WTWOHoOkXK7FNrqkvUw2lLpg0BFc82+c+IpvcNu?=
 =?us-ascii?Q?wbxOVVk7C8Sw+cBaEr0Vs74aDw5WtWkUkkGYa4++lhl8GCArYQrxDyHOgWdz?=
 =?us-ascii?Q?r+KfNzUkreRiwcunEBDqoCvhN8R3cWxakav4Z/sXe1gYHx5L9F0tPM/LXe4P?=
 =?us-ascii?Q?52/HNTHLTRPpzR9Lg/je4HADhRzRPDhxJseXLe1iPRr/4yFFcJz55H9sCNYV?=
 =?us-ascii?Q?KsLkYkHGA2RdOF9KU7r90IORGjmHc8c8b9xrdmufvAP/tas0VyGnK2eumjlf?=
X-MS-Exchange-AntiSpam-MessageData-1: EacxRQoqbiwf+KK62a89rUs40TJo4kyQcyA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6356e215-08a6-4923-e956-08de7e848a29
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:08:05.3133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qj7WSvYGaAmgvVFcoJUYsm5UGJMnVYs2Z+NMFUR8P4bW55EMj5pv8EiZJ9hScrqeU+yKIIHs53vOWOr3kbgmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10852
X-Rspamd-Queue-Id: 0B6E7248238
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.oltean@nxp.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,makrotopia.org:email]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 04:03:57PM +0000, Daniel Golle wrote:
> Add tests to local_termination.sh to verify that link-local frames
> arrive. On some switches the DSA driver uses bridges to connect the
> user ports to their CPU ports. More "intelligent" switches typically
> don't forward link-local frames, but may trap them to an internal
> microcontroller. The driver may have to change trapping rules, so
> link-local frames end up on the DSA CPU ports instead of being
> silently dropped or trapped to the internal microcontroller of the
> switch.
> 
> Add two tests which help to validate this has been done correctly:
>  - Link-local STP BPDU should always arrive at the Linux netdev

I don't really like the "always" comment here. The only reason why STP
is part of the forwarding plane and not the control plane is because the
bridge has stp_state=0. See br_handle_frame():

	if (unlikely(is_link_local_ether_addr(dest))) {
		u16 fwd_mask = p->br->group_fwd_mask_required;

		/*
		 * See IEEE 802.1D Table 7-10 Reserved addresses
		 *
		 * Assignment		 		Value
		 * Bridge Group Address		01-80-C2-00-00-00
		 * (MAC Control) 802.3		01-80-C2-00-00-01
		 * (Link Aggregation) 802.3	01-80-C2-00-00-02
		 * 802.1X PAE address		01-80-C2-00-00-03
		 *
		 * 802.1AB LLDP 		01-80-C2-00-00-0E
		 *
		 * Others reserved for future standardization
		 */
		fwd_mask |= p->group_fwd_mask;
		switch (dest[5]) {
		case 0x00:	/* Bridge Group Address */
			/* If STP is turned off,
			   then must forward to keep loop detection */
			if (p->br->stp_enabled == BR_NO_STP ||
			    fwd_mask & (1u << dest[5]))
				goto forward;
			*pskb = skb;
			__br_handle_local_finish(skb);
			return RX_HANDLER_PASS;

perhaps this can be part of the commit message somehow.

>  - Link-local LLDP should arrive at standalone ports (and the test
>    should be skipped on bridged ports similar to how it is done
>    for the IEEE1588v2/PTP tests)
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

With that addressed:

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Tested-by: Vladimir Oltean <vladimir.oltean@nxp.com>

