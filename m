Return-Path: <netdev+bounces-146159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589489D2245
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187B828309B
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946591A00EE;
	Tue, 19 Nov 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnoXXmkf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6ED19DF9E
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 09:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007675; cv=none; b=P/kD1so4D4YOclgZy2xqo/jZSyGgTqqTV8P1ewiIBIBw7nbmMbTR1m4614F38QI+XY839MeItt25/PzYhKt1zMfcC2WGdgUaTowlETQXq1J+vmeonG4srZH0CRiR7jjtMGWpir9BoaCtEx6u8KZsWO9d8QLrkw+7z6iWYTErUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007675; c=relaxed/simple;
	bh=3nEKZsLHpTms+OQqGSo2zvesoEI6VODK0/wFhdW8LTk=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=Fc52SJ0WrBD0XIFsuVcZLiV9UOMQ0p4nauzYWXwFr+Ox7NXC6w5hNBw1znFLSuHbvumLtdBymQvadJoV0yDM1yl2QQJ1hyWov+Cdx3BSfsFaflPGafpFjsboin8GOATY6cChwa4VmkW65T/pS5Pqa9/fF7aEUR1Wg5a9Ff+pMzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnoXXmkf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCB3C4CECF;
	Tue, 19 Nov 2024 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732007674;
	bh=3nEKZsLHpTms+OQqGSo2zvesoEI6VODK0/wFhdW8LTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DnoXXmkflWt4wsJW/rty53bKl5TLMu1O74Fh5d0S9pb2LStGnEv1q1ZrcocQ1jkvj
	 qBV9LU4f4Yb+BTRXPPL9o3S+PFHufr/dSVJ65qnxcKefMw05XxiBeuNzYqsnjAVI9K
	 TTEgQiUPs18r97wGhxsxrztD17cUpoLZa8j4Trej2SXIAs2OLf/jsp7ZkVAHKCcUuo
	 r5RkOv6Lz2EnkUX44r0xPPPGoHxW0hg8r+5h8u7dcJBHFwHuC63RVQ0EwAeLI13tUM
	 9m1FdDa8fy3uujPJEjoN7l+q5NU18TlBTCKGGNkCZ7Za1YF0zz6UTaY5B9eK4NJlK0
	 x260ltLUJrw4w==
Content-Type: multipart/mixed; boundary="------------AaD5cdf2dK8YDSVyBVzFYgHq"
Message-ID: <da1638d6-8235-4857-8f49-91152718fd4b@kernel.org>
Date: Tue, 19 Nov 2024 10:14:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] net: txgbe: fix null pointer to pcs: manual merge
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, mengyuanlou@net-swift.com, duanqiangwen@net-swift.com,
 Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org
References: <20241115073508.1130046-1-jiawenwu@trustnetic.com>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20241115073508.1130046-1-jiawenwu@trustnetic.com>

This is a multi-part message in MIME format.
--------------AaD5cdf2dK8YDSVyBVzFYgHq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 15/11/2024 08:35, Jiawen Wu wrote:
> For 1000BASE-X or SGMII interface mode, the PCS also need to be selected.
> Only return null pointer when there is a copper NIC with external PHY.

FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  2160428bcb20 ("net: txgbe: fix null pointer to pcs")

and this one from 'net-next':

  155c499ffd1d ("net: wangxun: txgbe: use phylink_pcs internally")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

Regarding this conflict, it was simple to resolve it because the
conflict was in the context: so the modification from both sides can be
taken: the new 'if' condition from 'net', and the new 'return' statement
from 'net-next'.

Rerere cache is available in [2].

1: https://github.com/multipath-tcp/mptcp_net-next/commit/74e6371ac34a
2: https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/631a1

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------AaD5cdf2dK8YDSVyBVzFYgHq
Content-Type: text/x-patch; charset=UTF-8;
 name="74e6371ac34a567f241de4b57ccbbc1741b3255e.patch"
Content-Disposition: attachment;
 filename="74e6371ac34a567f241de4b57ccbbc1741b3255e.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2V0aGVybmV0L3dhbmd4dW4vdHhnYmUvdHhnYmVfcGh5
LmMKaW5kZXggYTVlNGZlNmMzMWM1LDJlNjY2ZjY1YWE4Mi4uMWFlNjhmOTRkZDQ5Ci0tLSBh
L2RyaXZlcnMvbmV0L2V0aGVybmV0L3dhbmd4dW4vdHhnYmUvdHhnYmVfcGh5LmMKKysrIGIv
ZHJpdmVycy9uZXQvZXRoZXJuZXQvd2FuZ3h1bi90eGdiZS90eGdiZV9waHkuYwpAQEAgLTE2
Miw4IC0xNjIsOCArMTYyLDggQEBAIHN0YXRpYyBzdHJ1Y3QgcGh5bGlua19wY3MgKnR4Z2Jl
X3BoeWxpbgogIAlzdHJ1Y3Qgd3ggKnd4ID0gcGh5bGlua190b193eChjb25maWcpOwogIAlz
dHJ1Y3QgdHhnYmUgKnR4Z2JlID0gd3gtPnByaXY7CiAgCi0gCWlmIChpbnRlcmZhY2UgPT0g
UEhZX0lOVEVSRkFDRV9NT0RFXzEwR0JBU0VSKQorIAlpZiAod3gtPm1lZGlhX3R5cGUgIT0g
c3BfbWVkaWFfY29wcGVyKQogLQkJcmV0dXJuICZ0eGdiZS0+eHBjcy0+cGNzOwogKwkJcmV0
dXJuIHR4Z2JlLT5wY3M7CiAgCiAgCXJldHVybiBOVUxMOwogIH0K

--------------AaD5cdf2dK8YDSVyBVzFYgHq--

