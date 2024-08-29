Return-Path: <netdev+bounces-123203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E10A8964197
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1980EB2701E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33191AE856;
	Thu, 29 Aug 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRad7HSB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B0618E360;
	Thu, 29 Aug 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926805; cv=none; b=SmN4CHw8/f0WJXbE4xQrZh8P4Tk5zGzkPhCtG0nTnu0yAacRJ3UmK6sNs/YdPcSoYiRp/ockkv+7LyYmmjA876geyFf1L6+d4LO4ZCenkxmTdh3uapTY17KWQFTVCNFMqFI+NLFpPt6mxvysPJw2W73xwfvN/HS70qxnbcXsZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926805; c=relaxed/simple;
	bh=HfoDebrrdMTgjgIeGo1ad8UvhHmluv9QNZXmjJWWtHc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 Cc:From:In-Reply-To; b=nHgE/+QmYLu3qyNDNAnicVsVkDlUVbI+YAgo6ChQyXJFus2oDGrSfT2ZGzgI8/skwnOvn0ny4Ghw2AtbfeDR9A004Supv+OT5BOI5VMghbhNJlefMCcqiokw5s3xR0OFHUm/3eXnbqezP2/CU98ghAWvZFa+qgFkhyPhmMVsiCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRad7HSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15548C4CEC6;
	Thu, 29 Aug 2024 10:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724926805;
	bh=HfoDebrrdMTgjgIeGo1ad8UvhHmluv9QNZXmjJWWtHc=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=gRad7HSBdp1sUDXBW99cUvxXUb43s+a4e7PYu4iLI2dzB9cSK5fY52RVb0lrGm6b7
	 N2Hjew5A/cekQQzCInCfSRGr7QDIq3Re7JMD7KFeZW6bzctcvPEKu11ECKmGYm7CKV
	 xHtTEI5SMQcYLsZV/posfWJtXIeKcal4qW1EydLfeIQ2hLFDwiWnt85Bkf//tFUvks
	 //kPRavqaA8iHxXOvy1UznPaybux1E7KGqAOTV2jT+anK3Z8b3aqnWjM6gkqrIbAhN
	 QwnSsQe15VdZb4s52DrAW3g02YudI4BYfHbGtuttEinZUtV3HM/wMME4//FJ8vvUW7
	 xyI63k1TrLvQA==
Content-Type: multipart/mixed; boundary="------------Fa3F6ffuUGJe7vuBAGk4P4hY"
Message-ID: <0b851ec5-f91d-4dd3-99da-e81b98c9ed28@kernel.org>
Date: Thu, 29 Aug 2024 12:19:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3] net: ftgmac100: Get link speed and duplex for NC-SI:
 manual merge
Content-Language: en-GB
To: Jacky Chou <jacky_chou@aspeedtech.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
References: <20240827030513.481469-1-jacky_chou@aspeedtech.com>
Cc: edumazet@google.com, u.kleine-koenig@pengutronix.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240827030513.481469-1-jacky_chou@aspeedtech.com>

This is a multi-part message in MIME format.
--------------Fa3F6ffuUGJe7vuBAGk4P4hY
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 27/08/2024 05:05, Jacky Chou wrote:
> The ethtool of this driver uses the phy API of ethtool
> to get the link information from PHY driver.
> Because the NC-SI is forced on 100Mbps and full duplex,
> the driver connect a fixed-link phy driver for NC-SI.
> The ethtool will get the link information from the
> fixed-link phy driver.

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  4186c8d9e6af ("net: ftgmac100: Ensure tx descriptor updates are visible")

and this one from 'net-next':

  e24a6c874601 ("net: ftgmac100: Get link speed and duplex for NC-SI")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side[1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, it looks like it was due to a
refactoring/clean-up, removing extra whitespaces a bit everywhere in the
same file, and was surprisingly part of the fix patch applied in 'net'.
The two unrelated changes have been taken to resolve this conflict:
removing the extra space, and adding 'phy_stop(netdev->phydev);' after
the 'err_ncsi' label.

Rerere cache is available in [2].

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/ecf6b3c48b19
[2] https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/20cd
-- 
Sponsored by the NGI0 Core fund.

--------------Fa3F6ffuUGJe7vuBAGk4P4hY
Content-Type: text/x-patch; charset=UTF-8;
 name="ecf6b3c48b19f91d96881bd5f2d41e312bae58ce.patch"
Content-Disposition: attachment;
 filename="ecf6b3c48b19f91d96881bd5f2d41e312bae58ce.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMKaW5k
ZXggNGM1NDZjM2FlZjBmLDQ0NDY3MWI4YmJlMi4uZjNjYzE0Y2M3NTdkCi0tLSBhL2RyaXZl
cnMvbmV0L2V0aGVybmV0L2ZhcmFkYXkvZnRnbWFjMTAwLmMKKysrIGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZmFyYWRheS9mdGdtYWMxMDAuYwpAQEAgLTE1NTMsMTUgLTE1NTQsMTYgKzE1
NjQsMTYgQEBAIHN0YXRpYyBpbnQgZnRnbWFjMTAwX29wZW4oc3RydWN0IG5ldF9kZQogIAog
IAlyZXR1cm4gMDsKICAKIC0gZXJyX25jc2k6CiArZXJyX25jc2k6CisgCXBoeV9zdG9wKG5l
dGRldi0+cGh5ZGV2KTsKICAJbmFwaV9kaXNhYmxlKCZwcml2LT5uYXBpKTsKICAJbmV0aWZf
c3RvcF9xdWV1ZShuZXRkZXYpOwogLSBlcnJfYWxsb2M6CiArZXJyX2FsbG9jOgogIAlmdGdt
YWMxMDBfZnJlZV9idWZmZXJzKHByaXYpOwogIAlmcmVlX2lycShuZXRkZXYtPmlycSwgbmV0
ZGV2KTsKIC0gZXJyX2lycToKICtlcnJfaXJxOgogIAluZXRpZl9uYXBpX2RlbCgmcHJpdi0+
bmFwaSk7CiAtIGVycl9odzoKICtlcnJfaHc6CiAgCWlvd3JpdGUzMigwLCBwcml2LT5iYXNl
ICsgRlRHTUFDMTAwX09GRlNFVF9JRVIpOwogIAlmdGdtYWMxMDBfZnJlZV9yaW5ncyhwcml2
KTsKICAJcmV0dXJuIGVycjsK

--------------Fa3F6ffuUGJe7vuBAGk4P4hY--

