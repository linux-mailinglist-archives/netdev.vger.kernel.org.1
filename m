Return-Path: <netdev+bounces-256696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IyMN+BBg2kPkQMAu9opvQ
	(envelope-from <netdev+bounces-256696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:56:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A09E6110
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 13:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80FE43023DC5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 12:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71473E95B4;
	Wed,  4 Feb 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="U8y4SXC8"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host9-snip4-8.eps.apple.com [57.103.76.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE13314A7A
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209477; cv=none; b=uiJpxKvnnfR3FX+QvtolsyVA8eKhh1iUuAyjFPdkhK9Zj1nBkWSbywGCU6Fa0XoHYoPsxzZ7Ztf9gj6wTE9P73GXPErTAGPdqfyJOLFTiOtgw30FnMPmThtCQTW3K6/m0lq6uOmY6hVrTtQJVavnTMimFHmOZprIHH7wjT9jsks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209477; c=relaxed/simple;
	bh=hyiTmnyoKp5aAyvkcMsiAbjIzyeenCueakiKk9xiNJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NALVrdBgaCi1gDOUyIebUOkMSQ6WFPd4HRBGkvpMgvLj2dkdOOJ82JYF2DHtIhKkxU50rmcMAv7E55LKKHT06IBGRSs/zGNp4vGL5fgjOt8cglvZ2gXYLovmUgBkJMXCDick7AOWUlK5ZcFf9vnNTLfjUSZHTUO6f3E2L4/SgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=U8y4SXC8 reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id 36735180009E;
	Wed,  4 Feb 2026 12:51:12 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; t=1770209476; x=1772801476; bh=GJTb/54Z5+xwAzpTSRQUrcXvBdew3Ol34WshbO9jjpY=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=U8y4SXC8r4mP1JqcDZHck9yCM4QS73nRa4L7yTW8qqqq62qWKYOsbtcwpwltPRRRtrYkNYs66BW2N3yUgCbhBYY30TwBYY+hHQbfhYBpgLYPwHdg8wT2XdgfmoFwmJw4YFdaYSFHfQDoT9Oo1QGNQLbrjZqq210lEuRH5BbA/V9dvRU26apTcRuv6yXf05Rz48EYfT3yhak7RCeqDwkpyhsbdNr3fhj6w9JMrmUmUQtWhz6xYyuihP2d46n9D7hW2Mj3TE7Zs68JSFg4bh8Sp3RT4ZQTX66RJYCLoctYUcBh1VGqH7mngs7IJqHnQjerRz9wxt+WMEadtYr5kwk7Tg==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 344D518000A1;
	Wed,  4 Feb 2026 12:51:10 +0000 (UTC)
Date: Wed, 4 Feb 2026 21:51:07 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: ethtool: clarify the bit-by-bit bitset
 format description
Message-ID: <aYNAuwjJrkV66mD7@desktop.y-koj.net>
References: <e9ea0fe8bf7935d6439e4dc883414b685afbaf58.1770045398.git.yk@y-koj.net>
 <20260203195338.1b1fa65a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203195338.1b1fa65a@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA5NyBTYWx0ZWRfX7NmUEJFc99jc
 k1ccRXetdjHEFwRR4BsRQnyZL0EAyRBXj1WFl8bhvrL3jHTBrd76YcrwZdk7X0FaZDDypYZ4f9C
 oTuYpsEJUSDjpHPHjCulH0vq7uQEkgTI5JSokfaqZ02Oz0XBXsfhxOHU113AC6xP0c1odN2AetJ
 /ROBCQlciRNrjfwrwbLG9J2RN2VOE+e3/Adduf00Gh/eaWkfquvR5Vx1SN6Tgx5gtsAkKyV/MMP
 t0uvTBMNm1z6fS7lWBUbj8fcl0UVIOfBwAJxE5lxENY+5X2yFUaGLOK63bXn4QNUoz9zHxDomLJ
 8Tool5A24RvwR8BNNriO1pqGV+6tBjgosLeolcyiCrJK+9g8Ppmcg6vZhL1/pU=
X-Proofpoint-GUID: aZjGYkPqRURxn3ny5b5L4PB-AQYalVaa
X-Proofpoint-ORIG-GUID: aZjGYkPqRURxn3ny5b5L4PB-AQYalVaa
X-Authority-Info-Out: v=2.4 cv=Zvzg6t7G c=1 sm=1 tr=0 ts=698340c2
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=SN457lRnbVfGF1o8fXsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_04,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1030 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=714 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040097
X-JNJ: AAAAAAABle2D9FYh/ycboO5B0nHbL4HJBugysGx7t2ypDsTXyy/kCFIxES02PDlsjvXWDHM08w69YwI3DpJtXEBTdTRb6U6cmqVTmOk27mO7Bq3HfxLQNVY73+UCFjuyty6NRjgmQDw1eW8EtTKYrTlyhHGO9i1G7yb5oeMGeFaCwRChR1s0DiUwV3wSVPB13acI87WJmkGOVvt7auuGKA35c3nh2CvBi+HEfdEDUr/xninUKNnLDlANpzcK8+Cy5L6oNAcoM/oRPPNr7dsMWTbQoe9d/q3CAIWtc5rCWddz2Nbl9uAiosDcVEb02gXGnWU1rNqodd+vL1u4UPx50zEWyIDfbLMrF77FUBsvPRDlHmfix5OdP6VgzycPqMtSuns5FwAy0sXJyH42Ck9H0VW7Y6S+CbkcdDlvttFwapdZ1exV5npSrWRWta4X726g90a4K81MbQW6MlF/e5X6BBgW+Of4RazlrB9Oz1oFJe7G5iRDAAJro9qaJ7BJTy4w/Rm1brY1LVmOJrAFmeAkczuaC0DrRbUFUp1VioHyQaJPfqmiyKHkBeHW8DdYWxWVbgwGej2lk1tnD1ayeMFXaO2hwt2zhba8afWnLq+MmlwngHg6CH2vrIX4VtONt+ZQIOnThYBGUpuR/IMieTwemP0kFhcgvAGUjQIrz3LC3kCZLLfxlqpHYa4YIPkf/1szaCpezUXzYU0v0/30DyRiYBJcLtQXWImWWYC5vWGsbImBKg==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[y-koj.net:~];
	TAGGED_FROM(0.00)[bounces-256696-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[y-koj.net];
	R_DKIM_PERMFAIL(0.00)[y-koj.net:s=sig1];
	NEURAL_SPAM(0.00)[0.967];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yk@y-koj.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,desktop.y-koj.net:mid]
X-Rspamd-Queue-Id: 46A09E6110
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 07:53:38PM -0800, Jakub Kicinski wrote:
> On Tue,  3 Feb 2026 00:17:19 +0900 Yohei Kojima wrote:
> > Clarify the format and semantics of the bit-by-bit bitset by the
> > following changes:
> > * Explicitly describe the mandatory and optional fields in one paragraph
> > * Detail what happens if ETHTOOL_A_BITSET_NOMASK is set
> > * Clarify that users can set both BIT_INDEX and BIT_NAME fields
> 
> To be honest I'm not entirely sure which doc is easier to follow,
> before or after this patch :(

Thank you for the feedback. In the v2 patch, I'll focus on adding the
missing explanation rather than restructuring the entire paragraph.

Thank you,
Yohei

