Return-Path: <netdev+bounces-29690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2447845A8
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615B4281032
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CFF1DA25;
	Tue, 22 Aug 2023 15:34:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C71D311
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:34:46 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE6ECE6
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:34:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31aeedbb264so2827234f8f.0
        for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692718483; x=1693323283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+t39ZxccY2KvDqYDKzXBn289VzYrnhxPeif5Up0+bQ=;
        b=IFpgOZmFVhuM9rpYc/OBH2ePylYFR2/w+C5TcBBsolPDhnorvz5HDmODZWqj9q6cSA
         wMc18hwMArXY5jIGnjFPqLKBBSzhY/eHO1/t5p15TXJ84LH/VyS0UtimUYW//K2klMXD
         z0teXUR66uZtcmcRcCzuJ53xy7Rj56A1JIOLXNHL8+/ioDoAGc+GHWnXoGtu/2j9SZ86
         ziL1Vm9HPc7fk6VPFsDZ8hoZwWm3ELDtu41AZNg5Fir8k77ZJJyJRg1VfqpvwC5JizlG
         1sJ/gDSXs1xmRs00prAfcNp2O84lORAvM79FawBgz+c6stFjYLNIv9bC0NReI/FRjV0L
         gbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718483; x=1693323283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+t39ZxccY2KvDqYDKzXBn289VzYrnhxPeif5Up0+bQ=;
        b=G5y8jwxOuhOJ0tdzSrs5Jz8DnuDUN/xBa3u2YSTTtnIY78N/XU74P3QlHKM6Cri8lX
         tilyfdwNQlRPw2PyN47lO3Tk9chS6MRQEKlAxDnSrwVYZ8cI+5EA3tj2Km+Rd1E231Gp
         Wa5jPsHdKonVC64lXDaQg9dH7VRd+4+0/LGSUfDyGJdDQQcJP7QohHkx1jue9WoRbSw3
         wMvjkKCnbI2Pdp4ZM10SG4hRi/3p9zYTlfQEjkCBNPJ2tMxhX3vNoUVmnt2QWArGPiho
         4fNywkV+QTv9TXEW1UDxVHFB4QaLV1k889ODwq4bGlyJ55nv8hLIQgCKsxZ4JaJwPBpo
         K2tQ==
X-Gm-Message-State: AOJu0YyXzMSMPPN0E98UY3cK+OLfxAsM60bQRtigbd6BT/gUKk0JlUis
	7kSJxYBSyohNN3/fj6rHh40FTNjVkE2WTKw79pDhhe9D
X-Google-Smtp-Source: AGHT+IHNeLRVZyqs7W0FAvg5z/ZzXvJ5Dflhj2qKRLv7dQpDk4rbcoF0uJ9SE2V8xDcsnoVzBJuRpQ==
X-Received: by 2002:adf:e742:0:b0:318:69:ab03 with SMTP id c2-20020adfe742000000b003180069ab03mr7790238wrn.17.1692718483193;
        Tue, 22 Aug 2023 08:34:43 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d4d48000000b0031c5b380291sm5675352wru.110.2023.08.22.08.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:34:42 -0700 (PDT)
Date: Tue, 22 Aug 2023 17:34:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wenjun Wu <wenjun1.wu@intel.com>, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, xuejun.zhang@intel.com,
	madhu.chittim@intel.com, qi.z.zhang@intel.com,
	anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v4 0/5] iavf: Add devlink and devlink rate
 support'
Message-ID: <ZOTVkXWCLY88YfjV@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230822034003.31628-1-wenjun1.wu@intel.com>
 <ZORRzEBcUDEjMniz@nanopsycho>
 <20230822081255.7a36fa4d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822081255.7a36fa4d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Tue, Aug 22, 2023 at 05:12:55PM CEST, kuba@kernel.org wrote:
>On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
>> NACK! Port function is there to configure the VF/SF from the eswitch
>> side. Yet you use it for the configureation of the actual VF, which is
>> clear misuse. Please don't
>
>Stating where they are supposed to configure the rate would be helpful.

TC?

