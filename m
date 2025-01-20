Return-Path: <netdev+bounces-159843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4C1A171F9
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 18:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC94E1605D6
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C0D15098A;
	Mon, 20 Jan 2025 17:34:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C179D76035;
	Mon, 20 Jan 2025 17:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737394448; cv=none; b=Zl4YzlznDSC7ZkZse0VzaIv+CRi/5zNZJWPF0jurek4VWqnNAlW9iJ5cn/89SnmZ6OV9fVdqQlXp92xnClXL/bryiJNuKxE0XcwzjYjw31Q8SaIWdSwAl20GYqHkqo6ab+FM024jmvuY/rl+apO+oEtpnmChIWUhb7S67UkU+sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737394448; c=relaxed/simple;
	bh=zlhUfz9qdpLZWLoxjuEIZkzRTYwZR7w9ywBSUngmhH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7W6iSA9JhPid7iaQbL+kl6ETx54PSaSJquY+q0tadxHsnYjlWqDAlT9IZw4rtfYJrQ0fNbNOH5IWgQiv47bODX6O8yjHnp96exvR5qFLzvgRnCUsuWRbODFuME9QcRqvpXQ3pQIp+HXT4pBHpHEHPXdPy8cIzDJsIWrrz5SElo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso9844904a12.0;
        Mon, 20 Jan 2025 09:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737394444; x=1737999244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvChgV8LhQbOS06EeBHEpcR/aQmyY4yJckU7HCGLUxc=;
        b=fJGfERF8M9YnWTTVJ9iwZXMRQBR+pAl6QIYDjybBnXiqtklDAxeNnrSWaZWg1aSlRU
         5AM607vbZT8+lUHokHC9yCOu9SPJt5yNJkjnXWxeM1Cj7rjhCeJML6GzIrpknifiNpjf
         LkYB7DgvS7PK9HOM2ZimiwWeVkgfaVZAGyQKlwPHuRH1dU5zyqObzv0SMqYj1ZqmdsHs
         5xlP7zV0nijx3QwgGaps/WMeeDPPR0I1gNm6LnJBJG7lHhGNstJd5W7mcPvERP1w+yVl
         LG/9F7bYp+BtHwH5nvFYrblKqEtfLz/tMDz2H1C/ZmaK/Yxq0RleX6PaH8613bfpdc8E
         Dbag==
X-Forwarded-Encrypted: i=1; AJvYcCU/S7GB8I05mdP69Opx/xgkj8dcmZlQ5g7Sq7YJKKaMP86grEXgmjSdK8MN4xlZkw7UYcLenOOw9Es=@vger.kernel.org, AJvYcCVtx7LMIf0vZ4YoKSmd25Eoub/BZt1eNzzl98dRj6ItyR0F3eSgpvyLve8l7ZTvuJzJIgs1Mrrq@vger.kernel.org
X-Gm-Message-State: AOJu0YxITvCF/jLfwL3AdKfvaiNf7AYPUOJG+mjVVQxjJ/mLcI/yQNNZ
	9mu6gl115b/mDl7m1+QJ0AZ3jxfFvNRN5AaJw5wLkQTiAiSYqPwO
X-Gm-Gg: ASbGnctqJ40LqH/BYdbgmlkvaHxLqpHfXeHqhEcRoFi+2nHiIVXozsX0Y5MeJX+UbHE
	qmGxjEmjaCOpHyW2YIAFAWGA9GmRZYgRnG9WQlHma4SuRmecf7H6QOziWUktNOYCL3/eV3HJkKk
	/FERsYjN+lU9fLZry0aU8ajfaBpCVtkqFTgF5ncFycB/P/MdY1UkafxUmnYi2LrBX2TYZMIKZW0
	oHar7nbICFH3e8fIGzD+TgqNk/LZymnRBK8DIxADMTSlUpqmEIFHzRiETvU
X-Google-Smtp-Source: AGHT+IGWJfeAhB11gp2JmADY3iN6yXStM4NB5htCYIqWSroOnpChY8X+OtCfw9kHLjDwPF+Fpx7Nwg==
X-Received: by 2002:a05:6402:5110:b0:5d1:1f2:1143 with SMTP id 4fb4d7f45d1cf-5db7d300a02mr14262008a12.18.1737394443947;
        Mon, 20 Jan 2025 09:34:03 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683c1asm6000183a12.35.2025.01.20.09.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 09:34:03 -0800 (PST)
Date: Mon, 20 Jan 2025 09:34:00 -0800
From: Breno Leitao <leitao@debian.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Jakub Kicinski <kuba@kernel.org>, Daniele Palmas <dnlplm@gmail.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] net: usb: qmi_wwan: Add error handling for
 usbnet_get_ethernet_addr
Message-ID: <20250120-ginger-oryx-of-eternity-8c9ac9@leitao>
References: <20250120170026.1880-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120170026.1880-1-vulab@iscas.ac.cn>

On Tue, Jan 21, 2025 at 01:00:26AM +0800, Wentao Liang wrote:
> In qmi_wwan_bind(), usbnet_get_ethernet_addr() is called
> without error handling, risking unnoticed failures and
> inconsistent behavior compared to other parts of the code.
> 
> Fix this issue by adding an error handling for the
> usbnet_get_ethernet_addr(), improving code robustness.
> 
> Fixes: 423ce8caab7e ("net: usb: qmi_wwan: New driver for Huawei QMI based WWAN devices")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Breno Leitao <leitao@debian.org>

