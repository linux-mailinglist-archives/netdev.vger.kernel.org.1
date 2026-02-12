Return-Path: <netdev+bounces-258472-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBAaCX8Ejmlf+gAAu9opvQ
	(envelope-from <netdev+bounces-258472-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:49:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB0912F9BF
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80E64302AC04
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174B935DD0E;
	Thu, 12 Feb 2026 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="qz2QMYoh"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster3-host4-snip4-10.eps.apple.com [57.103.77.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E9C35E53F
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.77.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914776; cv=none; b=F2muSVqQ0LTDBeudBncl+BSdC4Q0KqvHTfl6V9oQifO+LLB1Rey7a/RcQZSJeN/4aOhv828KMAjNtV8rBlNCSc7sA1kIehtdRWZqQY1njzZKMUiZYgKrfSpdUZoVdxOMxpmW+c+GX1cPNUgPSMYHfw6kM5BcwD9FuViPgBLou6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914776; c=relaxed/simple;
	bh=h3BIh+xKb99MFMyx5fA5/y8xgOkkOyCiY+I8v/3z8YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGyutcfmxpJIgyXmMmxjDgkHlwPAIYMRgTAFqnqb1dGo04+bJ6BR1wkOyFNkp5DqLqKMwA1rEdpzxVidcJ3t8vXKGeJmmxxGJnDCPhW6D/bW7rz2AyVpQmZPpVhNwTV06rkbTzG3OsThunyxTqw/mZrwF90PV8w9HhVaQR6UO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=qz2QMYoh reason="key not found in DNS"; arc=none smtp.client-ip=57.103.77.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id 3B8681800385;
	Thu, 12 Feb 2026 16:46:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; t=1770914771; x=1773506771; bh=lx/q+HqmswEdLHARgaDdqtXI3jrwjUkBrv3ty7Hecv0=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=qz2QMYohPbmKUkJQL3Maysbc1U8mbxSt9LP3NsetGLij7owrlV+cPFE8ivctpoVYXMJJtpqas9X6dt1+FMpFNLjSJE7hl+5VxcykZhZjjHSHuNygN+r/GPtQ44v1HGGDOXuCX4YOx0l/q6iZm6C3ggDtWmc1uRzTGXH7r1cqFVfXB9sAT64y0Azn63sSa5WSMkcbYhN57S5HW1BtMdAld3XLB1viyFwHy44NuBDu814cs4RUC9F5OQFtntDz7MI/TxidtZp6AuboIThkzKe9V+XrEGp6ZEo083TSHOeKhMzhIQo6LiQomryKjgmRRrHQscXY4rtFMOdGeB7hZOydmg==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id BAD0C1800200;
	Thu, 12 Feb 2026 16:46:06 +0000 (UTC)
Date: Fri, 13 Feb 2026 01:46:03 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: ethtool: clarify the bit-by-bit bitset
 format description
Message-ID: <aY4Dy4JALgoc5_s8@desktop.y-koj.net>
References: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
 <f2882370-a531-4a83-ab39-cf73878c0d03@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2882370-a531-4a83-ab39-cf73878c0d03@redhat.com>
X-Proofpoint-ORIG-GUID: OeFxtA_vWDdqp2A-CksUiD7PdsHIuPUU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyNiBTYWx0ZWRfX3sL8vy0kZSii
 3hwbsFK69D3bPxjtbMW28vEZ12XpQVse+YvuoNW995YAz/5o6rhI4diZAOKJlQAm5FbwKw4wvtg
 EfUSCRUiGupF8JzjaAfn8bMv8Mc8ybFpPaMyZnM1VpTSRxdDGXCmEp3Rbm+RClXzrdAaPGapj9+
 Wd5b4O2CEvDcVAkpTxia526ASHaBeRcdmBOklttyoo6qkm9McHgAxFDLZWG0pmMg3sBa9OB0hPA
 mrdsGdOtT+WdM2upUtGrZxydpJGykBS2nx6YOzhzrfzAaeib1qrfmXON+o2aD3Vwpx0Q2LBmqkP
 9mzVTuD0UWgKOQI0INWiJg2Ar4SA3KkVso5jDS1yUy3YxhRXLletGEr1kV1Otw=
X-Authority-Info-Out: v=2.4 cv=AqvjHe9P c=1 sm=1 tr=0 ts=698e03d1
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=jnl5ZKOAAAAA:8 a=GezhIzodDrykCbhU_jUA:9 a=CjuIK1q_8ugA:10
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: OeFxtA_vWDdqp2A-CksUiD7PdsHIuPUU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 mlxlogscore=859 suspectscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1030 malwarescore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602120126
X-JNJ: AAAAAAABIZK6QK2kicOR2UZfbLws9NFEGoTwO3F1/nDque+JkIsnZe+p/ENLAYM0AdVdYvGDhAvybui2p9s8zmF0+9jHsb4e9JA+6R0tWU3J//7Ut6/tf1djMbB2KJELd+t96uKJy9b0TXS3Z4D0GW5aeaCA83muRol7JdOgkt4TWG+4KqdB2rnCmZwEpaiK0wly2KaSaN3slxnHKB++G5F9xvcMC0sms15t3KWjqXYbAGq9/5X1gxD57DL+1eEKA68OJEyp6sYKkwa4K7V2NsmqAakKcsVxKc8hQ+wTvURESLHu0QlqVDy7SHG/aiKYhUU/2ZHhuiv9ZJlc+FeDZ87ElTQGaoN+JmpWIYF0rl79DmFHy5mQNemJ5Ct56CrdGSY40+wCqMCNuSv8k96qfZlh24sS08M+zKa1gQHdgd0RQ7s5yCgPGJAhfi+so85VaxjXM6HPdgxp2vshgPzoDE9jfH21HCCPzo0797+EvhNHyfoM/Q/LLy/dmTL0Iol6sOq6KfYA/hxGtG/tOFWHn+o1KGspSnGNCXWpeLzGTUBhSbKcmH8t3ryt9sKrl1Mwyi6EnVGYNWFgm1Ysun6wWZKganKXJYqg9YwosA1fbVCtt/UO4HNQHqzLYis6WC+cC73kvXL6PMFo8XM9xq6FrzM6XcNov8Z+p80HK7iocHdGKOQqtAgP0+TiPTqrhamaC93gfVaLCwjSlIgFQvP+QsSg3dkaTt87LhKC/Pb7Ebl44Ttm0Z+u49xv/0ppr40=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[y-koj.net:~];
	R_DKIM_PERMFAIL(0.00)[y-koj.net:s=sig1];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258472-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[y-koj.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yk@y-koj.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CB0912F9BF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 12:55:55PM +0100, Paolo Abeni wrote:
> On 2/7/26 11:25 AM, Yohei Kojima wrote:
> > Clarify the bit-by-bit bitset format's behavior around mandatory
> > attributes and bit identification. More specifically, the following
> > changes are made:
> > 
> > * Rephrase a misleading sentence which implies name and index are
> >   mutually exclusive
> > * Describe that ETHTOOL_A_BITSET_BITS nest is mandatory
> > * Describe that a request fails if inconsistent identifiers are given
> > 
> > Signed-off-by: Yohei Kojima <yk@y-koj.net>
> > ---
> > Current ethtool-netlink documentation doesn't describe several behavior
> > around bit-by-bit bitset, which makes it hard to develop a ethtool
> > library without digging into the kernel code. This patch eases the gap
> > between the kernel behavior and the documentation by adding descriptions
> > around the mandatory attribute and bit identification.
> 
> This needs review by someone provided with English natural language
> skills far better than mine. I'm wrapping the net-next PR right now;
> this has to be deferred after the merge window, I'm sorry.

Thank you for the response. It's okay, I understand maintainers are
super busy during this period.

FYI I've received a Reviewed-by from Jakub, so I believe it's ready for
merge after the merge window.

Thank you,
Yohei

