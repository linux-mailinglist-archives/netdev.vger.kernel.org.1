Return-Path: <netdev+bounces-131271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AD98DF3C
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F09D1C24E57
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A1B1D0434;
	Wed,  2 Oct 2024 15:33:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B789A23CE;
	Wed,  2 Oct 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883194; cv=none; b=jBzk4ew9KLaRHN1A9RfYs6lrJn8zpdkRBqMJ/51V4cz7t7LVIMv4cqfSQCIkyTnSfnQ/ywVsekefBqDzH1uDC6jwokIkAtUNxqnKLBFHMizJ8KIwxNGlseEWBVlIQpeZ1u0hHnDX6IRs3mH0gCthJo4qCwIgeHjSuDiC3lxYIqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883194; c=relaxed/simple;
	bh=1gw/RFjefYRq/TSJcFZ9d6JXFRUn5ifgoyqgOoIlCZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWo5JD/IStXQhHu1A03knElktxFv+ex6m7Ars6UgLpEzj8idDa14J/1ddGmkm/nlDp5PDqq1L6RI5klP7t/xBVQoKmSoexJYz8L0BpSPJ1cNBm4zEczFe0jwHv3TYF62hH3kr1xsg7e5/F1ahNgPL18klO/w1apj/cvRhLw2CAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c88e4a7c53so5043822a12.0;
        Wed, 02 Oct 2024 08:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883190; x=1728487990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTCC5mB2mGzfNB4TYhiqO1fgrb24xTtLHLngV8SMhOM=;
        b=X1VGzOgB6OBVvYAOQzzxf7VA2+URlz+Az16iFR4f4LLWP3InNHWTYvyLxSDjzxCN7F
         7nyzWT80rfRj0yvwURwpcZssy13Q8E0wqv1329MgNcWO/gbabukuIgh8jWs5ZUuh09r3
         vYsQDXIoehHayUC3nS18DHfC31g42WLWsgqvIiZesiMD3P+rK9QoG4th6lSs9g9hMShu
         9NoRMy7xAYN75TaxmWkeAlkvWjB4kP07Zs4hNnUA1tkltT9MhGfKTgzaTjs3MO2rUuVQ
         ANfXoTl6f7OnCUD/L9vfjPskWMOqJ+gqvBfaubUMp/WPMt+j2Qk0ixLngdTwwCwnIgOX
         vP2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAB3qZPKsNuKC7uOxetLNE2OGba0f5JQMkxjgZbpfdxFCvAdW8bYmWvai7z6+ZJsw5XL26nNxEx1Y=@vger.kernel.org, AJvYcCXGbNW07e/a4L4ItJRa42ykD+JAlUmicssqfrwkXPxDbVkxzvQikWlPBBosIkKPFgxShBldRtZK@vger.kernel.org, AJvYcCXRGnXwXl40+9/2AlFJoeTBD9q4HrfagrlZcYPdNp+rmg4qNmolvO2pvtWbowZxDPDx7NGUiC5spmMbsTLr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoj6CizkoslV2uWy6AUAI5EeX9I/RJCi2EcnuK8vBOf5M/QX3b
	P/tVpd8WW8tHNPIpt0D/teetUCnwQspLcmfhbSBUJtE9teSjd1d9
X-Google-Smtp-Source: AGHT+IGTlngDvQyE5XHwlb44NSGdHpKYSFmAAOESzaCUberpiWnak0XiuQK3AAQr1QsG1u1ZsCrJiA==
X-Received: by 2002:a05:6402:268c:b0:5c8:bb09:a2bb with SMTP id 4fb4d7f45d1cf-5c8bb09a86dmr1662321a12.0.1727883190093;
        Wed, 02 Oct 2024 08:33:10 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8824051b7sm8045167a12.7.2024.10.02.08.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:33:09 -0700 (PDT)
Date: Wed, 2 Oct 2024 08:33:05 -0700
From: Breno Leitao <leitao@debian.org>
To: kernel test robot <lkp@intel.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, oe-kbuild-all@lists.linux.dev,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241002-vague-wapiti-of-aurora-ffec3e@leitao>
References: <20241002113316.2527669-1-leitao@debian.org>
 <202410022209.2TB3siPB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410022209.2TB3siPB-lkp@intel.com>

On Wed, Oct 02, 2024 at 10:23:25PM +0800, kernel test robot wrote:
> Hi Breno,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Breno-Leitao/net-Implement-fault-injection-forcing-skb-reallocation/20241002-193852
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20241002113316.2527669-1-leitao%40debian.org
> patch subject: [PATCH net-next] net: Implement fault injection forcing skb reallocation
> reproduce: (https://download.01.org/0day-ci/archive/20241002/202410022209.2TB3siPB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410022209.2TB3siPB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt
>    Warning: Documentation/userspace-api/netlink/index.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>    Warning: Documentation/userspace-api/netlink/specs.rst references a file that doesn't exist: Documentation/networking/netlink_spec/index.rst
>    Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/reserved-memory/qcom
>    Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
> >> Warning: net/Kconfig.debug references a file that doesn't exist: Documentation/dev-tools/fault-injection/fault-injection.rst

For those interested, this is not an issue, since the fault-injection
documentation is changing to dev-tools, and I am referencing the new
localtion already.

https://lore.kernel.org/all/87ttethota.fsf@trenco.lwn.net/

