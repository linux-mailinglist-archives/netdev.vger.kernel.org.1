Return-Path: <netdev+bounces-159538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B0A15B4F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 04:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B0E188AF5A
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8B7DA6A;
	Sat, 18 Jan 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg4O7nHq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6111C1F95E;
	Sat, 18 Jan 2025 03:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737172278; cv=none; b=JLOaYti9k8afRmmSVKohjCqCBCW0rHrTCEck5C9JaNgMqcLvqn7mSTzeKBtXUnRpYK3pj0Ki6xIOF63lMjxBzFfro4R9p+ao/9iljoLmI1QqKG36zxbqxHanSP5W/f9JTz4NKdA47RmL0H/d7sbRz0PSO5E0EX1xfsqXPBhnjSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737172278; c=relaxed/simple;
	bh=/DyfZWIIA96g0Ckt/iF1SREvxeObReWViBxkd40Wrkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kq+3y7M4ljpKOxwRqmgH1IBDadtIE2+pqaa8Hn7aG5WuhEehYlnR+99O+x92zzr5pIdpwX+gK5vgzZqAcCEoe3bnUxW7gq+0fPWDszCQBY8epinTSTJFeXkKALa5p3UKFdJBTZKvC20kqSFUMWBr9Vn9sZKOdKk4m6qF9D+o1gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg4O7nHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A859CC4CED1;
	Sat, 18 Jan 2025 03:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737172278;
	bh=/DyfZWIIA96g0Ckt/iF1SREvxeObReWViBxkd40Wrkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wg4O7nHqeAoZVFYyETYyeYu6pLx6d3Q1QDps4UyzGqUKor6alhi/0n71XGBldQ4HW
	 TZHLh9qrSEZu5RiK1HiCETkuZ1otS4LxtUJY6RwUDnfymgyNy3ZbrOKVDeEBj9q7CU
	 UXN0fhkBZw7KqeXXZPBMGEXi55Z/M9coD9wv2rMoS8l9qMX42xjPco8QGcWlCVpt7r
	 gBzDWBu+xgQnyce5DuwaRJ4ubCN1fvudUEEqWXVRWjVTxqmFncxVG0lakKlY4uLFez
	 v2s8ETIJ+tuqmEYDoo6wEkJkG31MGrlc4fLDXUJLpJQYAa6foQhUuxHZJMAuI2mox+
	 CQFRLjx1V97pg==
Date: Fri, 17 Jan 2025 19:51:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew+netdev@lunn.ch
Cc: Ninad Palsule <ninad@linux.ibm.com>, minyard@acm.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 openipmi-developer@lists.sourceforge.net, netdev@vger.kernel.org,
 joel@jms.id.au, andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 eajames@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] dt-bindings: net: faraday,ftgmac100: Add phys
 mode
Message-ID: <20250117195116.4211ef42@kernel.org>
In-Reply-To: <20250116203527.2102742-2-ninad@linux.ibm.com>
References: <20250116203527.2102742-1-ninad@linux.ibm.com>
	<20250116203527.2102742-2-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 14:35:16 -0600 Ninad Palsule wrote:
> Aspeed device supports rgmii, rgmii-id, rgmii-rxid, rgmii-txid so
> document them.

Andrew, just to be sure - you're okay with extending the bindings?

