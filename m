Return-Path: <netdev+bounces-155512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 437C9A02A66
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FE73A59F6
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF05B1DDC36;
	Mon,  6 Jan 2025 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFb7sKSO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA2D1DC9BC;
	Mon,  6 Jan 2025 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177507; cv=none; b=Ys5eTlAuijUxQTGKkkDPGVGqi3w4VF0Z/h/zcNwYxIagr+U4yFUdQ//hkXeMqFrOcboWo+5WhV2mBIqWu6tbRUUzY8qW0btGYr/GBrb/JZxU1g6sSwe1P3ihBWweMylUsGAVBbLgpl+5i8v3jOPbyvvUyyE5SN6u4QbOo2JL5Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177507; c=relaxed/simple;
	bh=1CDx1KZGRF4KtODc2j+SU0Oxq5Hi2xlNf9VcrcJLqqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FglsVRjWG0gcuLz5G6TpQvObYHMPC+jVFsXQYHxGUHNceaXYhATpS3VdNpIfsiM+lZ1apZ6fq64L9Q4kauSJ5JM0nwIH2v8EbfosdDocrMf94Jsf8c4ka8X0s9kjrkz0P/A2Zk/oWiLul8DacOjNPMmNOfmuZOsoGkBTK2DYlnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFb7sKSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA0CC4CED2;
	Mon,  6 Jan 2025 15:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736177506;
	bh=1CDx1KZGRF4KtODc2j+SU0Oxq5Hi2xlNf9VcrcJLqqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DFb7sKSO2QFKTzxUlzKpGjsRN72jPlJpkBXFN41PwOH4CD0/V9U+e0Hw6AtNLwJaI
	 bQ2uCiSQXbjeMmH2HzLqsJgxL2TJSTIZjlkiurAP97teLBJpxDFwSB0cEwU+OS9Dls
	 mVblcoJvq/MQ6Zu8NWV4V0fkrI0qYGW705tiPXS2+KC5dWnUdnId+TR/gZ3g2PHqSf
	 Wn9S3FZ+MqWXCZOTwRF7r//0UyRM8Vk1L8D0J/xAcXSLYV5tRiTBynTT55LgrW3XWA
	 A3Xe0gwm+jsD0a9xNcu0iXY4FN8pF7ByHelEF62GblFbOj7A4laXq4MaSa8T6k0gr7
	 j5meuSF1u6T3w==
Date: Mon, 6 Jan 2025 07:31:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Su Hui <suhui@nfschina.com>
Cc: alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 jdelvare@suse.com, linux@roeck-us.net, michal.swiatkowski@linux.intel.com,
 mohsin.bashr@gmail.com, sanmanpradhan@meta.com, vadim.fedorenko@linux.dev,
 kalesh-anakkur.purayil@broadcom.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] eth: fbnic: Revert "eth: fbnic: Add hardware
 monitoring support via HWMON interface"
Message-ID: <20250106073144.25d6b9fb@kernel.org>
In-Reply-To: <20250106023647.47756-1-suhui@nfschina.com>
References: <20250106023647.47756-1-suhui@nfschina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jan 2025 10:36:48 +0800 Su Hui wrote:
> There is a garbage value problem in fbnic_mac_get_sensor_asic(). 'fw_cmpl'
> is uninitialized which makes 'sensor' and '*val' to be stored garbage
> value. Revert commit d85ebade02e8 ("eth: fbnic: Add hardware monitoring
> support via HWMON interface") to avoid this problem.
> 
> Fixes: d85ebade02e8 ("eth: fbnic: Add hardware monitoring support via HWMON interface")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

