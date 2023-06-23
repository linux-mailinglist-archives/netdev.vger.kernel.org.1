Return-Path: <netdev+bounces-13378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC1873B672
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A681C20C4F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 11:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F223100;
	Fri, 23 Jun 2023 11:44:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20309230FC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 11:44:09 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B019A1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 04:44:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-311183ef595so575806f8f.0
        for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687520646; x=1690112646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3rB+dgkrEcwRWpwe+fMVe50xF5rM3gNf2XNcEl+xLg=;
        b=sPbm0NNP5Ah7KUY+4kDWWMF7XKj08Ies72DWy5JYo9RwMAQ51qWM0Q6Yj06T63RItH
         KTF3APChAZEPbWdGYh2mDLSnkvlpTa5nzJyywaLdW3qz+0EhXYN8CU+lG7B+4nraHAo2
         h4lC7Sa/+r6cxQvtowya4uQuCJsAa6KgTpv0ikmhhm40DYXlc1aunuF6xgw4AJze3z5d
         Ou4b8s/C3Cvx/rltP6DHT4KVLkR9KrJqe7eUH+LYdAJlLIZBfUXsPKZN4cek6HBFLxMN
         AB/+mupDeCiRjVLpgUoe0AYkDrNVzOUkTPan4IF/AYaNRSVMdd9pUOQkwGBfl9GAtH+9
         TaXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687520646; x=1690112646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3rB+dgkrEcwRWpwe+fMVe50xF5rM3gNf2XNcEl+xLg=;
        b=lff/OhwBDU+QWIt8KPm1SKHBIDhuyXMhD9FDNg/ZflrTGLqdC9hvMe/wa0J/CArszR
         GJz28PkOllMqxx0QOKY6z1Y1+8vw6ENzI3Cr7PPamgPFSooQQ+4plOwQ1mSkgbg/2p9e
         y2b0nbiZps+OlS5Z1mBvli8x93pR0U4THLIA1VXnV2rx+wvQvh7EJspt45LG0c51jH0p
         zmvEEmDy4ShGrddUAfHhfemDb8Xoqa8j4lpTmIG+011EP3WMLZ6dP+R+sdNbUX02unfr
         ET1ziR0jkmjts1cDHk7XxryM/eAz5mbE7dJum9ZrDEVmI8SvGPxbwnH1B8AYq60s58Vh
         HOJw==
X-Gm-Message-State: AC+VfDxiwnmclm5QBITlusMCxV2/gshyYdej6CaP940h3aEsphc+/j4M
	QIqRvD5jLRcvgvquF3M+NqADZw==
X-Google-Smtp-Source: ACHHUZ4nYGYbiJkV1RjU5mrRbFBYVjmQ2K6ko5uoSyccZGSlyJrAl7f8/YrN7xgyrRr2f7+zxCQN+g==
X-Received: by 2002:a5d:6148:0:b0:30f:c029:7538 with SMTP id y8-20020a5d6148000000b0030fc0297538mr16051568wrt.46.1687520646210;
        Fri, 23 Jun 2023 04:44:06 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p1-20020adfcc81000000b0030ada01ca78sm9372521wrj.10.2023.06.23.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 04:44:04 -0700 (PDT)
Date: Fri, 23 Jun 2023 14:44:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	"maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
	Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: Move validation of ptp pointer
 before its usage
Message-ID: <3894dd38-377b-4691-907b-ec3d47fddffd@kadam.mountain>
References: <20230609115806.2625564-1-saikrishnag@marvell.com>
 <880d628e-18bf-44a1-a55f-ffbe1777dd2b@kadam.mountain>
 <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY3PR18MB470788B4096D586DEB9A3B22A023A@BY3PR18MB4707.namprd18.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 11:28:19AM +0000, Sai Krishna Gajula wrote:
> > This probe function is super weird how it returns success on the failure path.
> > One concern, I had initially was that if anything returns -EPROBE_DEFER then
> > we cannot recover.  That's not possible in the current code, but it makes me
> > itch...  But here is a different crash.
> > 
> 
> In few circumstances, the PTP device is probed before the AF device in
> the driver. In such instance, -EPROBE_DEFER is used.
> -- EDEFER_PROBE is useful when probe order changes. Ex: AF driver probes before PTP.
> 

You're describing how -EPROBE_DEFER is *supposed* to work.  But that's
not what this driver does.

If the AF driver is probed before the PTP driver then ptp_probe() should
return -EPROBE_DEFER and that would allow the kernel to automatically
retry ptp_probe() later.  But instead of that, ptp_probe() returns
success.  So I guess the user would have to manually rmmod it and insmod
it again?  So, what I'm saying I don't understand why we can't do this
in the normal way.

The other thing I'm saying is that the weird return success on error
stuff hasn't been tested or we would have discovered the crash through
testing.

regards,
dan carpenter


