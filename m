Return-Path: <netdev+bounces-57313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5E812DC4
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAD01C2148E
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4863D39F;
	Thu, 14 Dec 2023 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAwDqErh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D19D7F
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:53:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1f653e3c3dso878365266b.2
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702551211; x=1703156011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b4xdDLVag0ZgO6prT+qC+tDi0V8J2q58AzNyrvL+9nM=;
        b=eAwDqErhcMS3YLiEJQ41MrquVrzKu9NlOue+N8L6r6qYSB6X0SMzp2zaMzH/Y3+cES
         wPK4jWVKzUrCw5+n8NwrH+Y53OAUeNXCidW+YZc4oVHhFOKCiZO4JcPbjx3Qxdbirkhy
         g40GPpJTrV4U7bS3xey3jEHADthGTWluHoOOEZn50r+P8m4T//kVakJMjAbKcB9KPeYF
         M8Sa38JSguK4wlC+EiHAMHt+y0TN/0wqHTI2HEmA/m+scS9nvp1+g/HRnqCNusQ/28Ju
         pklyykc3LOq2ra762QtLzW3q7TKVyHaw5unDpCp6fQqDCE3ZwUpRDQccL2ZhGGx960bw
         lKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702551211; x=1703156011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4xdDLVag0ZgO6prT+qC+tDi0V8J2q58AzNyrvL+9nM=;
        b=Dk5iUOIRNC1FLc3eb6d3ovl739TQCKTG4WUVpPNcETtqAg/6ZX6daLroYa1H62UxP2
         0v+XaRHa0mpEFAkMuO/gCr9541YGYRrBplf4bm65N4y32JaJFArPCK9dLjSUjzzl+J/C
         XQeM/SJoS5VXgZ2WI29E3anEzbgQFJLypV4Vm6grhaWgDL7dqJjAWm+ry9iqNBo6Dvk1
         GjcmBgVdQZkxR+VaimiVxgzFPBjcbj4a/jUCLW4Aw4DaKNeADOEul+Q6FXnsFADG3hVb
         yvB8hyV0euadP4KHMQ/JZMymi8Vq+BYQgiR2xucog6k7PN0dPXWGTAQSGwcsD5HPyHxZ
         Oasw==
X-Gm-Message-State: AOJu0YzLCzFJmLoGV/3AaM0S3XTGAAFtTZfkQcOmCwvSCs3Qdydnro4x
	UCJLQqPQP5u4NqPeMDY1Zew=
X-Google-Smtp-Source: AGHT+IFjC/vDlxjG/hSVGd+GGbomzsGjxRagqq+iyYKtkpL3C8L8uMijLVxkdE/C76QUEyS2qM/FFQ==
X-Received: by 2002:a17:907:720d:b0:a19:d40a:d222 with SMTP id dr13-20020a170907720d00b00a19d40ad222mr3248569ejc.238.1702551211321;
        Thu, 14 Dec 2023 02:53:31 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id tg3-20020a1709078dc300b00a22fdd1722asm2285425ejc.122.2023.12.14.02.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:53:30 -0800 (PST)
Date: Thu, 14 Dec 2023 12:53:28 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: andrew@lunn.ch, Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 6/8] net: dsa: mv88e6xxx: Limit histogram
 counters to ingress traffic
Message-ID: <20231214105328.3kftoisqieodqlnr@skbuf>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-7-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211223346.2497157-7-tobias@waldekranz.com>

On Mon, Dec 11, 2023 at 11:33:44PM +0100, Tobias Waldekranz wrote:
> Chips in this family only has one set of histogram counters, which can
> be used to count ingressing and/or egressing traffic. mv88e6xxx has,
> up until this point, kept the hardware default of counting both
> directions.
> 
> In the mean time, standard counter group support has been added to
> ethtool. Via that interface, drivers may report ingress-only and
> egress-only histograms separately - but not combined.
> 
> In order for mv88e6xxx to maximalize amount of diagnostic information
> that can be exported via standard interfaces, we opt to limit the
> histogram counters to ingress traffic only. Which will allow us to
> export them via the standard "rmon" group in an upcoming commit.
> 
> The reason for choosing ingress-only over egress-only, is to be
> compatible with RFC2819 (RMON MIB).
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---

I guess this needs an ack from Andrew.

