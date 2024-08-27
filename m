Return-Path: <netdev+bounces-122462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF85396167A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C590B2415E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDA11D278A;
	Tue, 27 Aug 2024 18:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfsTYf4L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A5E1CE6E8;
	Tue, 27 Aug 2024 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782138; cv=none; b=kibe+BXNML43uF6ztDDiHZCjI3KeMVVWUyxgvBXx6fZtq+Q8AEX5ppTpzxtRAh2BbCVuU2bRJDcxg1DI2CPrMMO/BELBCEjktWdoLqqUGqUI2bRhRFSo2k/Xf40ES11iyqPPMkQjjb9xpVsfHZlgnbF+8K9/c/NMFdO6w+6OB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782138; c=relaxed/simple;
	bh=vPRdnXcxzOvqwsl31MwpvcFEo2tS10nXApdk3u4GrMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYPDbw9CX1AGC2A7yiNxYcU80unKUU1zkYr3RlRBS8yNm09ZthSeENcxFf0hHbaPTe8z4BqMURmwJE3DkmbNV4TV4OeQ1N69ZSrlnr2BqR4/0fuEK06q3PZR0xEipE2WEt2gbrC18W96ctRH1jkpJzPpDl7daL34PrKc0SKiW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfsTYf4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5E5C4AF19;
	Tue, 27 Aug 2024 18:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782138;
	bh=vPRdnXcxzOvqwsl31MwpvcFEo2tS10nXApdk3u4GrMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XfsTYf4LMwlW7krx4xXbZmqu9HLUZGMEMLYfnjRrPD8etgttmrVU992IssYZ1ckZo
	 bccuAXlvfB0+9gvluXFVhLC6dudd5wOj81J7B6Qdrgw7UHJz6kXIuNC4dXbs5EEAH3
	 ku5A4OfRKeCWjt7R3j68XUBd+MsO14Tniy6h1CyzbYMFi/ogWaaitBaFSGnhp0pZgC
	 eIBcSi+6VMo8ZqRjvUmoRd1CybcKJGAqBXrdnsyMcJy91Hj5wyWOaf1f2o0zzq9LOK
	 HeECVMS3awJZ65rqrcP3Tin3c4SWCd83SsIlbY7aRVXG/Fi2TGXxOSg1HN51BLvXfv
	 DF4gfJhC7PYQQ==
Date: Tue, 27 Aug 2024 19:08:54 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RESEND 3/3] net: hisilicon: hns_mdio: fix OF
 node leak in probe()
Message-ID: <20240827180854.GV1368797@kernel.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
 <20240827144421.52852-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827144421.52852-4-krzysztof.kozlowski@linaro.org>

On Tue, Aug 27, 2024 at 04:44:21PM +0200, Krzysztof Kozlowski wrote:
> Driver is leaking OF node reference from
> of_parse_phandle_with_fixed_args() in probe().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


