Return-Path: <netdev+bounces-247094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94CCCF4776
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 16:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 632883002BB1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F0C33A706;
	Mon,  5 Jan 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="6plVR0A3"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster4-host3-snip4-10.eps.apple.com [57.103.78.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF4833A718
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627378; cv=none; b=CmS+5E5tsIBq9diTV3P1xnfE7r7h8YhrDnAt5xm3Zg3QiTAwHyA47t0agk4ef433AObFUfeUBqB64+svOew9xfw/A/0RZvlA9OBukKA5ieD3gcbs7K26VZbLZMEVXsrEkHbNJP/4PuA5SaSu6Hv8pr77AoUgca/HfgrJdlKBNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627378; c=relaxed/simple;
	bh=oDTaovpRprFmvzFEZnVBrWTvRdWi9h4XTEdN39v9z6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfek3/HqRJ7T+X6G0IB6yeZzRkNn0iU98fpfBgu6eB6Z7PinocnNQj7/xMyvc9UzBCvQNYQan/lesQV97r2CVyMQqW8CYBi86UpvioVDGcmR7kLB97Z9ct+vw24auAMj6ua8MMvRzGnBZeDaTSxdrp5hCDWdZjZMwYg/5nQeJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=6plVR0A3 reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPS id CF86F180014A;
	Mon,  5 Jan 2026 15:36:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=9l7XPMJcx7buD8+DBtpWzbddsFc5VNP+qd05I7VbKVY=; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=6plVR0A3uyBxcmT6Z4ZY2y9TG8DvKc0y0HEVzMRwN4I3yrdd25WQQiPRqimRwfhjM1FZ07URSl8cVzdb4dPKzPge79JKOS8fhilLaI7LZVbvCyCb1Wq3aQrNGKyAK4OHwz9mxIEZNw/oZHVhu7Nd0Kp0ah+oMLua6GSqjRaFCfsEt5/TDnSY/AY8irDbvD0GmMAFJ4avqJC3kalQo6ufyrprpkuYbtiZMXjGctY1oN3TuimO/9H7FHX55006h9fzqj+lb50v7qdQxvfObcLWcJMgnCmbJV5eiFgsa5/Sl28W16004tPxImv7cA+LHj/ePEzbU+NlvcpBuXjd+jnXag==
mail-alias-created-date: 1719758601013
Received: from desktop.y-koj.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-11 (Postfix) with ESMTPSA id A6A3718000B0;
	Mon,  5 Jan 2026 15:36:12 +0000 (UTC)
Date: Tue, 6 Jan 2026 00:36:09 +0900
From: Yohei Kojima <yk@y-koj.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net: netdevsim: fix inconsistent carrier
 state after link/unlink
Message-ID: <aVvaaeoutGR0Fk7W@desktop.y-koj.net>
References: <cover.1767108538.git.yk@y-koj.net>
 <c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
 <20260104105422.57542bd4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104105422.57542bd4@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDEzNiBTYWx0ZWRfX/J4V96CE4G08
 op/J6VG9XTJoPFAm9q8g8t/xrpFiTGyCeV36cbAfrwbPpiXsEmlLZNPEVnJnELDaetIncpTUceK
 lN7TDa3EmhYbcWI23uy2P2WFjHMFHW3y38g8cNEcuF/0S0qIg9NtNeUYDD3qQMBrIeO/m0+xxEA
 COE6ppsLAU7IHGVelYoH1wO5Eov6DGaaTwB8hyuOP4h7XRcpGXRw/ypQaSZAjHEk8YShKTKSDbz
 0fJBaGjo79tuOQPVf1Z0VhKs3ZYMj6JXThC6a8MLLLhm29FzR5LoI1Q+K+q3nccMAEuIl7dpE5U
 4dmllCTry4VlLXHG8HV
X-Authority-Info: v=2.4 cv=XrL3+FF9 c=1 sm=1 tr=0 ts=695bda6f cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=jnl5ZKOAAAAA:8 a=strKB1PheGmEXTCzyUgA:9 a=CjuIK1q_8ugA:10
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: LN0qllijSxaWzDPoUWmzZQenelUZJOfT
X-Proofpoint-GUID: LN0qllijSxaWzDPoUWmzZQenelUZJOfT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2026-01-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 clxscore=1030 spamscore=0
 mlxlogscore=534 malwarescore=0 adultscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601050136
X-JNJ: AAAAAAAB0rTBVp6Akvgke1Sg09rToxaARUPTwJV93tG3yeRW37RHiNpDj4zTqvLuvNoHgbBpp4azjSzJXll9OZlGxyTahpjzC37PDcShUa9T5Ev7Vcq/EkgM1Hjkf8531DR5sYVz0p7frdgEObdr+19JTlVR3fyRkIzhwHPIWVizER/Hw3F6y7XczsiNpQZDWUWzzSDQCseJRwwgdIJPsNCOJxzpslkTdO6jnH+TwwnRVrHaUe1uTYzHIpSV4iVehWouutejGpddjq8fkonuNSeerHRLpX0W6bqF4k6xI/wP2zJaDHbtDXsq6CdjAwoafz24TvHY8bxqB+y1YhJzRo2czph16kehr+GpW2ZX4t9A74FlckkTHVbPY5QZawyl98cNMpNBG75HOS9uwGhK0iR0en3qNu/rFL6I2FqwRV9RBejxk4oR54nYGU1atVVvyuw23eMJdVR+DbnnSOCw+JUSTWHCqS8sy9KPeY8c/1XmM5Gh14LBy+UuUnoKDIZiiHgOLi5eKWKFf9y+ztfmuSgkPWK1qe6Ae402kQKUWcXDG7lYdBwgRWwqAeZraGSDEmtVN6VAOQkkYNqoc2OvBPE8ksRZX2+/DclKF9sFwNay7fhJ7qHgfuPWT321FZCS/t7j2aZiRM8UyXm/nAKRwHpaIABJQrabQ3qJ9t7sZKE9ZgRQktsAbxsfsJOt98KCRAzDZEjarrA+ZpbqQmLN5I/llHydOm0wHl0D8oYiUSYU4A==

On Sun, Jan 04, 2026 at 10:54:22AM -0800, Jakub Kicinski wrote:
> On Wed, 31 Dec 2025 01:03:29 +0900 yk@y-koj.net wrote:
> > +	netif_carrier_on(dev_a);
> > +	netif_carrier_on(dev_b);
> 
> 	if (netif_running(dev_a) && netif_running(dev_b)) {
> 		/// your code
> 	}
> 
> right? If one side is down there should be no carrier.

That's right. I have updated the first patch with netif_running()
checks accordingly.

Here is the v3 series including the fix:
https://lore.kernel.org/netdev/cover.1767624906.git.yk@y-koj.net/T/

Thank you,
Yohei Kojima

> -- 
> pw-bot: cr

