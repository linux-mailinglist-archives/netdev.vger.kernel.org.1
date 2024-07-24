Return-Path: <netdev+bounces-112725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B2A93AD6B
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EC311F22EA7
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 07:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C8112F59C;
	Wed, 24 Jul 2024 07:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C2574409
	for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721807415; cv=none; b=hYWTKC56c3gIcjRzHDliTiTR4bESgZOMshiwGuivicCbt+dDqk0tpEjSOziu14kqar8yyoHm5kF82wdEJdDooCzsBV1j1iPvLfhRRDSX1N48TG4yYxUXgluu3SgZUZ0L4mzhFvWXiOuY0oP3KqkcePEPjD39Ek3JKj/gyiWnOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721807415; c=relaxed/simple;
	bh=vmal0nsk6eOwatdoTVQ/OiZqEtQVuC3rWgnPtse2kN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgybUWD1bv6oWRz5YnIwT8+h0y1qrsTKVBMENhem9P8U4Rh1DuxqdCumLnyiYIoetvhVXDS4jqCWL4hZqgSx7s9VmWnDzc7UIsQ0wB/oGvwGkMoknlUgsduwa1uXRx82OLG9Higob3g17yzTCCby1An91Fp+SUQRgHi4QCTESEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52efbb55d24so5858453e87.1
        for <netdev@vger.kernel.org>; Wed, 24 Jul 2024 00:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721807412; x=1722412212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmal0nsk6eOwatdoTVQ/OiZqEtQVuC3rWgnPtse2kN8=;
        b=JWzM1OfRrjLGaFPBuyqTDmQU1MaWoLXqcZyROi1koH+6TAXdC/zXOXOLQPpMFFH+aY
         hErL/SseaLrsOwX6tHEQ/NwpVmuIIosW5Ey0WZiiPdNwljd0jhPF/4GEToRDVE49Ak/+
         /7X2Eb7JGrDjV7dJI3TAq2aeXGD6XIC3KIJ/UUZFIOxKf0ajDBBhCTfpL+vxC7G5OmdA
         OI923BXJe5t6Xcwj+hPgYcmYIIDF3awkmjuqnjTulZOTOy/EF/sTLdQq3j/S1ifwuxbB
         /r2BVBWAmhs+3vBRELS78SfPDTRGwumYk52qdn+VkN82pb4wIQc85Atgc8WRjtMoukY7
         oZ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkJ6d1Weie6BXmoOkeKw6CQalCuRoYUTXc1cNMjI2iLfvlMugxzLIWN8Qt0fhYCqJZL7xsWuXsfMijcnerFWduqGzaldyB
X-Gm-Message-State: AOJu0Ywt4KC5SJDRhrt2Houo6HDhlmX5IK1C7MKZhjXTGP4Gc3ad3/zW
	hActSdzj/FdXSU/4/BnORnFmWIH7IrPF8BsL1WVlI/An2m1wLGLF
X-Google-Smtp-Source: AGHT+IHqaBxDjgKkGlNPhDekR6aPDcq80WTv+lkHz3GSvG9k5QvINzMI9/XffkTxlplVpCCA6uQl6A==
X-Received: by 2002:a05:6512:4011:b0:52c:9877:71b7 with SMTP id 2adb3069b0e04-52fcdaa8ea8mr1828976e87.59.1721807412028;
        Wed, 24 Jul 2024 00:50:12 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a879f155asm192814066b.53.2024.07.24.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 00:50:11 -0700 (PDT)
Date: Wed, 24 Jul 2024 00:50:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: make Breno the netconsole maintainer
Message-ID: <ZqCyMYiX1nSeevNO@gmail.com>
References: <20240723223405.2198688-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723223405.2198688-1-kuba@kernel.org>

On Tue, Jul 23, 2024 at 03:34:05PM -0700, Jakub Kicinski wrote:
> netconsole has no maintainer, and Breno has been working on
> improving it consistently for some time. So I think we found
> the maintainer :)

Thanks. I am more than happy to be the maintainer. I think I
finally understand the code fully and I am happy to continue to work on
it.

> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Breno Leitao <leitao@debian.org>

