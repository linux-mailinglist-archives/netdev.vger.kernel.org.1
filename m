Return-Path: <netdev+bounces-157324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D6A09F81
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 01:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7835216AD9C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50210940;
	Sat, 11 Jan 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzCQExFe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872994A1E;
	Sat, 11 Jan 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736555547; cv=none; b=lRQQKfu7nh1NOMOqnQd2Wdx/7vTWjqoxqtFkgqGW3LWqQ5aM+hf9dDhcXaUIDi24c9SqZE8MibFQtT0VfR+Sx8wM625pkXt6zvE8bI4uyN9fVnA/Z/Y7O2QYvclxinl5vS0uKoifIImChCP/P5I5adqvGGM9NEZpV2lLgejFiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736555547; c=relaxed/simple;
	bh=JOFIcvbuJlhifKowMvawmFUkoKsClUIawnqMWiLAFq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+SYA2lMqaKSzGbj7asJiiJu8q7M7MJbO0q8pvkUFeKyobubQn2Q+mjkxW+3eoqX63oFCVCFhI7yZojAiIVHKqDX5rrufeW0B2nWe57LDIubbTAK9pNmWTQV4F2KqBLkjI5QE39uLDWy4LD9e5mQNr5L4UDaeEN6rv6Q+qR6IEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzCQExFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56602C4CED6;
	Sat, 11 Jan 2025 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736555547;
	bh=JOFIcvbuJlhifKowMvawmFUkoKsClUIawnqMWiLAFq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KzCQExFeEsTy3SYJkzhG8qaBdMf0eqxSmc/jAqimbUHU7YWtor0UercWiK1RyN2Kk
	 DRXhTWzU/jWHbSGMcTihMgFqO6v2tKbTK2vXBQMN2NPXH1WNoUNAsDpUvKpuP32vS8
	 q26hLGAJP3KQ0uXk2KrtFsrL1Hq2H/y1zkQ4jzKsoVBK2Q5Mf8ewbHk/l3qxs3QMww
	 +xm/v0eMw0nJq9zHa3/f1tbHsIhP6+DtHEXDxWj2DgKh5L22h2IGImQXii8JHXQ/ti
	 /UakO5n+BYWkAyGDIotO993ZMrG6xn4gE86lkJVntc1ErEyLYWVStLt7souOZvO+xM
	 7aZ/84MuxSGVQ==
Date: Fri, 10 Jan 2025 16:32:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>, Lei Wei <quic_leiwei@quicinc.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, quic_kkumarcs@quicinc.com,
 quic_suruchia@quicinc.com, quic_pavir@quicinc.com,
 quic_linchen@quicinc.com, quic_luoj@quicinc.com,
 srinivas.kandagatla@linaro.org, bartosz.golaszewski@linaro.org,
 vsmuthu@qti.qualcomm.com, john@phrozen.org
Subject: Re: [PATCH net-next v4 3/5] net: pcs: qcom-ipq9574: Add PCS
 instantiation and phylink operations
Message-ID: <20250110163225.43fe8043@kernel.org>
In-Reply-To: <20250110105252.GY7706@kernel.org>
References: <20250108-ipq_pcs_net-next-v4-0-0de14cd2902b@quicinc.com>
	<20250108-ipq_pcs_net-next-v4-3-0de14cd2902b@quicinc.com>
	<20250108100358.GG2772@kernel.org>
	<8ac3167c-c8aa-4ddb-948f-758714df7495@quicinc.com>
	<20250110105252.GY7706@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Jan 2025 10:52:52 +0000 Simon Horman wrote:
> I don't think there is a need to update the code just to make Smatch happy.
> Only if there is a real problem. Which, with the discussion at the link
> above in mind, does not seem to be the case here.

Maybe be good to add a one line comment in the code to make it clear
this is intentional. Chances are we'll get a semi-automated "fixes"
for this before long.

