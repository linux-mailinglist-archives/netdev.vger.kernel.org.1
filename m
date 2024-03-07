Return-Path: <netdev+bounces-78410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FFC874FB4
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 14:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A226C285999
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 13:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D94412B141;
	Thu,  7 Mar 2024 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy1yw8jd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0996D3233
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 13:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709817196; cv=none; b=EEEWgq652UD8TzUGJmzthehszyndWF5uIBoNGIWnwRlcUqpdNuzSVBbEN0W+EtPM6qTAjhzmU1wxUxawE6TYGrfYHkKpO/aEoTDJsa8QtmOE7QtGLU2CJjMW4w3gOdV/stDR3gnHSGCuuqOjgtRf2qLwT0BdJOjEYkeDxQciEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709817196; c=relaxed/simple;
	bh=v/hY3SM6hvTs0j0uE0kBS3HHSnI8C3maDR3OrLnOtpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKQB3lt4TDe8IQYEfxVSCivIdZsh59bA/FjfWgGBEkQwcV348H29WWGaDxj12QS4TyO2xHjuZR4S7t1pnNzePQMaiBcGKqj3HbSMHc85F9hwph9I0kCwq6EEkDJL1fP8LF40VSMib9zpLxcyvWoK83dewztBuHaa8LkTjLSfsbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy1yw8jd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0288DC433F1;
	Thu,  7 Mar 2024 13:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709817195;
	bh=v/hY3SM6hvTs0j0uE0kBS3HHSnI8C3maDR3OrLnOtpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cy1yw8jdB1CV2jbldyCpekytR+d0qTVrImVaTwpH3htaZk20Ixu5YhwxAvk3V1E14
	 OY9svQChWDCkMPoWH2G2XgX3FyvHNN+uoFzgDF3ceOh4XV8Qro3MU3HZPXzRYDSYeE
	 pX06jddetAJMNd1xrQOdW91QuFcnQVvlrseBuSspUPxewoClh3ghSc0O0l7dweqOz/
	 o8/zRRvLqtawbgzsNr4xKUkYpqQqZqGfSWs5piizCLmLmMYNiG9DqOjDQbD9e4/kMP
	 7V2rWlHO4Y1sxqvOE5wOEPnaEj3PJaY5i8vt0LnMVgIsxZa+7lYM1za/OQqAC2KUas
	 64XOzVxD06kXw==
Message-ID: <574661cc-5f25-401b-931c-cf82e535f536@kernel.org>
Date: Thu, 7 Mar 2024 15:13:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 08/10] net: ti: icssg-prueth: Add functions to
 configure SR1.0 packet classifier
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, dan.carpenter@linaro.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
 <20240305114045.388893-9-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240305114045.388893-9-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05/03/2024 13:40, Diogo Ivo wrote:
> Add the functions to configure the SR1.0 packet classifier.
> 
> Based on the work of Roger Quadros in TI's 5.10 SDK [1].
> 
> [1]: https://git.ti.com/cgit/ti-linux-kernel/ti-linux-kernel/tree/?h=ti-linux-5.10.y
> 
> Co-developed-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

