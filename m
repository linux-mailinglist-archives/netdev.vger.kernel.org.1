Return-Path: <netdev+bounces-209257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44A6B0ED2D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 10:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9756C7F78
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 08:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60553279DB2;
	Wed, 23 Jul 2025 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0ppCUP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11F19C540;
	Wed, 23 Jul 2025 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753259282; cv=none; b=u5vDai6OEmyFzVEbtASkayg15eLeO5PBAzkXm6evvxLpyc/J9ejJ9MtLyABjDFXLeTj+bI9G3xh0FWUL8dgjvpQ/+kAwItOiKedx0Q+7nHCWoUGqyO/NmYnNRUQUz/DcJfZha5jh7qgu/TvwEaSyVf5UjgsoyEaMQ3boxucugdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753259282; c=relaxed/simple;
	bh=XgENzyZs64BF5nAIb/haZKUbKZCRqyyD0si/40yEwS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAKdqbQsFJKq81lrv441AgWfSczc/6MFScpR34e1PlyumoS2ZH9EHBfIMd7rA8CcMxm8MmIb4PM5L40mc9OriXIwDvnyKgFeBkFaTBwap7YSThpOdexOblb5lxxfbBRNYL2cgLj61I6XGY36hrlyyQ5qQIzRZkSFdPFjBKa8WMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0ppCUP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0994AC4CEE7;
	Wed, 23 Jul 2025 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753259281;
	bh=XgENzyZs64BF5nAIb/haZKUbKZCRqyyD0si/40yEwS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X0ppCUP0np34VyjIFq5Lf2biP95ePV1mn0A+4J8NPX4yU5a7RIUaEA9ZgQ61KaIZB
	 K84cMlnwl3DKwfPzNAmtxUGYYDxErELzYG3oDqDyvTMgxwd0fh8t2mxFB92AT1ofij
	 SFJ1K7pgNOmit08JDo9ZRWdqKVRKXf4R3a5XzPoLkvATuSkeY0kAEEvKdALvZ88/fP
	 +DCYoOXicEE6q1W0uuo6y3Yluj7vA9f0KUy2uoX4TYLZek2D96aWafNjx9/WSP6oon
	 LHfpM2FmrVAsOQ5WCKPKyx8etgGKcNvK/T9z+itK58M9DBoTNCv/XwqqPQrO6pO3pm
	 U5pDq5QODCL3w==
Date: Wed, 23 Jul 2025 10:27:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel@oss.qualcomm.com
Subject: Re: [PATCH 6/7] dt-bindings: arm: qcom: Refactor QCS9100 and SA8775P
 board names to reflect Lemans variants
Message-ID: <20250723-messy-woodpecker-of-diversity-18ddcd@kuoka>
References: <20250722144926.995064-1-wasim.nazir@oss.qualcomm.com>
 <20250722144926.995064-7-wasim.nazir@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250722144926.995064-7-wasim.nazir@oss.qualcomm.com>

On Tue, Jul 22, 2025 at 08:19:25PM +0530, Wasim Nazir wrote:
> Remove qcs9100 SoC and rename its associated boards to "lemans-*",
> to represent the IoT variants.
> Rename sa8775p based boards to "lemans-auto-*", derived from "lemans",
> to represent boards which uses old automotive memory-map.

No.

We have been there and you got very clear feedback that this is a no-go.

NAK

Best regards,
Krzysztof


