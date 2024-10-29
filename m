Return-Path: <netdev+bounces-139960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC319B4CDA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 16:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FD2B22FCC
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921D19342D;
	Tue, 29 Oct 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC4pjSGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753EF193079
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 15:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214234; cv=none; b=cnDcVqfHX5RxOaMxnPRif3rYyyYuijA8+UuGqyzyCiTd4ggMf82zSNzc6r0zBMeC20Szg/ivCbCrpRy84yAO9WrZXwhIpCoGYdue+0sDi4E5q8BiyRLYgjh5sNR4iGsYQ4lJieqDw1cSyD8j/4dL4iXrU0HpSNfid7IK15Kjlko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214234; c=relaxed/simple;
	bh=+4f7PCOoI/fdIUXXXYHNnqcDpbQ5ZLaX+3yk0MZqwv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lWPkPHDoVURiyXe4078CP8J+lcNRvMwSxxb5LgImwsRDblXRilJbzVP/hG61cv5Wmqz6ma1/qRJZZA9vGfDqtGi+rQUrt+dLIiXfT/UQyCLhO65N5VHXZS6hHry29iwP0As406CmiOtLQWrJImTh/jzbaXJKCLsEUVaGFcFKLDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC4pjSGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B5EC4CEE5;
	Tue, 29 Oct 2024 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730214234;
	bh=+4f7PCOoI/fdIUXXXYHNnqcDpbQ5ZLaX+3yk0MZqwv0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ZC4pjSGSYfzHiEW4lu+eCKHEl3ODH+1XMmVTPIDv/NjqLGrKTHaoED6Zrd2MDxAFi
	 P6A8JX/kuSMKhtrla3Ppgr11QyocHqJF0xrNNoBCrgIk/FmvwBLqQQsDvngIyZPNTe
	 7IZ0nIUVN3z9VCY3jNaj56D9QFnv8hTsRUsBcG2krf45FzD8rxKXxYpL4j1hsrq9fU
	 qr/kUlteCEt/xqJlwfuHp9b9rjQ4HzlCAfwXcdWsY2PsBHAL6Fhbq3XknbF5C+fgbD
	 gIYZ5RlUZbQNoViPe2vP3W7BmNwAkzCxtyy7UzetMMKN2LjxjCZEtYlRB29uISGTk2
	 R85jKM1bBrHYA==
Message-ID: <ca8a1945-3a02-4830-b39d-5e90c0515c91@kernel.org>
Date: Tue, 29 Oct 2024 09:03:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] rt_names: add rt_addrprotos with an identifier for
 keepalived
Content-Language: en-US
To: Quentin Armitage <quentin@armitage.org.uk>, netdev@vger.kernel.org
References: <20241028234420.321794-1-quentin@armitage.org.uk>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241028234420.321794-1-quentin@armitage.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 5:44 PM, Quentin Armitage wrote:
> keepalived now sets the protocol for addresses it adds, so give it a
> protocol number it can use.
> 
> Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>
> ---
>  etc/iproute2/rt_addrprotos | 4 ++++
>  1 file changed, 4 insertions(+)
>  create mode 100644 etc/iproute2/rt_addrprotos
> 
> diff --git a/etc/iproute2/rt_addrprotos b/etc/iproute2/rt_addrprotos
> new file mode 100644
> index 00000000..f9349dee
> --- /dev/null
> +++ b/etc/iproute2/rt_addrprotos
> @@ -0,0 +1,4 @@
> +#
> +# Reserved address protocols.
> +#
> +18	keepalived

iproute2 now allows apps to drop custom files in
/etc/iproute2/rt_addrprotos.d, so this can be managed within keepalived.

--
pw-bot: reject

