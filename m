Return-Path: <netdev+bounces-75044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CF867E26
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 18:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442A51F2E690
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 17:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35478130E2E;
	Mon, 26 Feb 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Omqh14pQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CF2130E2C
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 17:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967994; cv=none; b=oq80C4D4iZvtD6TufWYtMsPdVcjJXN9p0NV29sPE/Y0lQ6SK1idgpT4gl2fwozck002ijaWKxNoIm47OkDLFJO4hdCN8OKwJjAkGYzV2hRfhwHsO8qGKy/707j9X+q47A7FNGMtCujjEvoVF2IOFh9mdpKyBNXfabRJ/SbukD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967994; c=relaxed/simple;
	bh=t/0TRcaVv7hmy4dWqb+tr1xbOJwE7wtonKYBQ/8EEY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HbL0hmMwKyhtkXAlqoy+GbrxgQnJpSv/9githBwiKGcTo9iKuwm0iJe3n0vAepT8fNuH+gPUpY9rjfxlL/NUbz5HJToP5QaSDkuJNIiruF6N2UQfrynKCdBTVfDBO9NU9lnsMdGW09lJvIyP0k3PouLHJxEKTJDBS4mWQigYlQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Omqh14pQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D939C433F1;
	Mon, 26 Feb 2024 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708967993;
	bh=t/0TRcaVv7hmy4dWqb+tr1xbOJwE7wtonKYBQ/8EEY4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Omqh14pQWbVvqoGnHK4hYx2+tAWm6Wz7Ab333g4eRogINUy88j+UvW9cr0d4TLope
	 mi9Tn9/pfP+jM0kN0wPOv9QpVzxDXyj19Cap/Omlv8BRNimLDSWsKMnFQTdm0kev32
	 3bLtc6wGoaKvOfEZKUXvkLOvQ+UkY7caTAP0RqW79/F53eIKxJn6x7f7PAU91410Hg
	 41+d7VX9E5MAUixSaII6sdnk0q5R580f4bc/VnF7VlhOSOoeFvxRg/MJmgB6QaNkH9
	 wjMloQRdg51Ww5Q8NVweGB00Z9lh7YoJvuizpfeezIZAW96ftVvaD8DAUPqwVovsUi
	 ck4IVyz0RC9bw==
Message-ID: <2c81fc54-c5f4-4f6e-bd54-ea51b3c9ffce@kernel.org>
Date: Mon, 26 Feb 2024 19:19:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ti: icssg-prueth: Adjust the
 number of TX channels for SR1.0
Content-Language: en-US
To: Diogo Ivo <diogo.ivo@siemens.com>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-8-diogo.ivo@siemens.com>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240221152421.112324-8-diogo.ivo@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 21/02/2024 17:24, Diogo Ivo wrote:
> As SR1.0 uses the current higher priority channel to send commands to
> the firmware, take this into account when setting/getting the number
> of channels to/from the user.
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

