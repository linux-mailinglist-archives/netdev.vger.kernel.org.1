Return-Path: <netdev+bounces-14615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426B742AD6
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E9E1C20AD1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E1125C3;
	Thu, 29 Jun 2023 16:51:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ECC33F5
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:51:43 +0000 (UTC)
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 29 Jun 2023 09:51:39 PDT
Received: from smtp-out1-04.simnet.is (smtp-out1-04.simnet.is [194.105.232.35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD8330F1
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 09:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=simnet.is; i=@simnet.is; q=dns/txt; s=sel1;
  t=1688057500; x=1719593500;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jzgCmSBjkPBQ/pviKOqgZmxXBkRLi7Qz9alWtjzRseE=;
  b=d3kXYh6nnRnyh4cCBPVhX6ktd5eg5aKrDvt8GpcoqXnCktVe5T4CFYY0
   qCxMRRH0TiyCftmqomc26RqYWc/majwyLmpczATBpWOy0C29PKMBvFpa7
   65lYQjzHyPpDLgKawx7q8ErIAwukmLjdNxxG6vnoRmhywWB5AXexhpojS
   W2Z6P4UZ0N7GchfTF7aafBj6NPr5VpLvrkyKT1xVn7l1ih1aNBtE6hs3F
   i+bQU0HxNyEJ9dyzMxYOKcB5ZJ9jApx+TCHWF4yQGm+YPGmhWj8Dz47/5
   dhvOZPjpZzxwxxG8UU72UyRNE2e5gAGPf7DtlOzmWwHHu3ksYCdS2kl4W
   Q==;
Authentication-Results: smtp-out-04.simnet.is; dkim=none (message not signed) header.i=none
X-SBRS: 4.4
X-IPAS-Result: =?us-ascii?q?A2EaAAAKr51kkFnoacJaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YIydYFciCGEToh4JSGFcZgAgg0BAQEPMRMEAQEEA4FMiT0nNAkOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQMBAQYBAQEBAQEGBgIQAQEBAQEBIB4OECeFLzkNhF0sDXkBB?=
 =?us-ascii?q?ScTPxALDgouEEcGgxEBglyuXoEBM4EBgxiwD4FogUIBkW08BoINhEA+iwYEj?=
 =?us-ascii?q?iGFYwcyjDKBJ2+BHoEgegIJAhFngQgIX4FvPgINVQsLY4EcglICAhEnExRBE?=
 =?us-ascii?q?ngbAwcDgQUQLwcEMh8JBgkYGBclBlEFAi0kCRMVQQSDWAqBDD8VDhGCWiICB?=
 =?us-ascii?q?zY/G1CCbQkXDjtfagNEHUADez01FBsGJQFJgVcwgUYkJKFxhTSBFLBWlFmEE?=
 =?us-ascii?q?ot9lWSFRJE+DJI3mB+oPIFBIoIWLAcaCDCDIglJGQ+XVoo3dTsCBwsBAQMJi?=
 =?us-ascii?q?0gBAQ?=
IronPort-PHdr: A9a23:yKZhLxBT8jUTN3MAl1F5UyQVQxdPi9zP1m898Z87k/dJb7jmp8ikJ
 03a4/hxyl7SDs3X6PNB3uzRta2oGWkN+o2Iv31KdptQHwQEhsMbk01oAMOMBUDhav+/aSs8E
 ax/
IronPort-Data: A9a23:/ooh4605YxChYTEPovbD5TBxkn2cJEfYwER7XKvMYLTBsI5bpzFSy
 TcdCG6FOqqCYmX9etp/PYiy9UIG65HXnd5gGVZo3Hw8FHgiRejtXI/AdhiqV8+xwmwvaGo9s
 q3yv/GZdJhcokf0/0vraP65xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2LBVOCvT/
 4uryyHjEAX9gWUsbDhFs/jrRC5H5ZwehhtJ7zTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8Qi0vtYx/yxWZMV7FLH7zXeXluGixh3nQ3HW3Oh2B2YabL82/tdMHjQbn
 RAYAGhlghGrmeOt3PepS+x0nMMzPYyzZ8UBu2p8izDCZRokacmSH+OTvYIehmxqwJAfdRrdT
 5NxhT5HZhXGbBxAO0w/E5M7muq0wHjkG9FdgAPO/vVrvDCKlWSd1pDEd9XLZPiQb/98uUSA/
 2bc3na6JB4FYYn3JT2tqS7817CewUsXQrk6GKax9vNwhnWQy3YVBRlQUkG0ydGilkOmW99ZA
 0oZ5jUpt6sq8FGuRNTnGRqirxasuBMAV9dOO/M15RvLyafO5QudQG8eQVZ8hMcOqs4tWXk41
 1qRhdT5FHk36/uLSGmBsLaPxd+vBcQLBUgvVCZUbDsP2cb+uIoUokP9YNJSK7Hg27UZBgrM6
 zyNqSE/gZAagsgKy7i38Dj7b9SE+sihoukdu16/Y4610u9qTND4OdzytzA3+d4FddbBEQje1
 JQRs5HGtIgz4YexeDulYd5l8FuBzvWYKjDNm18H83IJqWz1k5JPVaZX+i1+KU5yLq45ldLBf
 k7IpUZD5ZpLJny6fOovOMSvCt82i6n7fTgEahw2RoYRCnSSXFXelM2LWaJ29zu3+KTLuftuU
 ap3ie72UR4n5V1PlVJavds1374x3TwZzmjOX539xBnP+ePANCHEFuhdagvTNrpRAEa4TOP9r
 4c32yyilk83bQECSnCOmWLuBQlQdiNqX/gaVeQLJr7rzvVa9JEJUKOBkOxwJ+SJboxQl+PBt
 nGzMnK0O3Ki7UAr3T6iMyg5AJu2BMoXhSxgZ0QEYw33s0XPlK7zsM/zgbNsJ+J2nAGipNYoJ
 8Q4lzKoW6UeEG2ZqmRAMvEQbuVKLXyWuO5HBAL9CBBXQnKqb1WhFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:YOcEV61+22erRGiCcp6FJgqjBfdyeYIsimQD101hICG9Afbo9P
 xG/c536faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOJ/9SjIVyaygc378
 ddmsZFeb/N5BRB7PoTxWGDYqpQv6j4gdHY9ds37B9WPHNXg5oJ1XYLNu+EKDwKeCB2Qao+CI
 G7/cQCgzKhfE4cZsO9CmJtZZm6m/T70KLhfQUhHBBizAGPiAmj4Ln8HwPd8QwZV1p0sM0f2F
 mAowrk/YO5vbWewh/Y7WXa6JNbg5/A57J4dbWxo/lQGjPxkSCyasBEU72Ghjo8p+ai8xILl9
 bLuBMpIsR07BrqDweIiCqo6w/9yxA05TvHwV+cu3Hqpsv0X3YBEsJEr4NUeBmx0TtagO1B
X-Talos-CUID: 9a23:Pbw5GG8NUWISykvJrpOVv2k5K8l1U03X9mjNO0SfJTdbZrmkckDFrQ==
X-Talos-MUID: 9a23:h5TIognsFlCNm2aCsSKDdnpLc8h2/YC0Inoktpce4s2eFD4zHTiC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.01,168,1684800000"; 
   d="scan'208";a="933747011"
Received: from vist-zimproxy-03.vist.is ([194.105.232.89])
  by smtp-out-04.simnet.is with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 16:50:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 96C8C412AEA5;
	Thu, 29 Jun 2023 16:50:32 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
	by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iePxpatT_-BV; Thu, 29 Jun 2023 16:50:32 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTP id 12331412AEA7;
	Thu, 29 Jun 2023 16:50:32 +0000 (GMT)
Received: from vist-zimproxy-03.vist.is ([127.0.0.1])
	by localhost (vist-zimproxy-03.vist.is [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2ifMKxui0XRE; Thu, 29 Jun 2023 16:50:32 +0000 (GMT)
Received: from kassi.invalid.is.lan (85-220-7-150.dsl.dynamic.simnet.is [85.220.7.150])
	by vist-zimproxy-03.vist.is (Postfix) with ESMTPS id B7650412AEA5;
	Thu, 29 Jun 2023 16:50:31 +0000 (GMT)
Received: from bg by kassi.invalid.is.lan with local (Exim 4.96)
	(envelope-from <bingigis@simnet.is>)
	id 1qEuql-000Ebv-1A;
	Thu, 29 Jun 2023 16:50:31 +0000
Date: Thu, 29 Jun 2023 16:50:31 +0000
From: Bjarni Ingi Gislason <bjarniig@simnet.is>
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
Subject: Re: tc.8: some remarks and a patch for the manual
Message-ID: <ZJ22V4RxekUmretl@localhost>
References: <168764283038.2838.1146738227989939935.reportbug@kassi.invalid.is.lan>
 <20230627103849.7bce7b54@hermes.local>
 <ZJuChT7GPgEpORaQ@localhost>
 <9e9d932b-79df-e67c-abeb-b50bbb81b95a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e9d932b-79df-e67c-abeb-b50bbb81b95a@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 12:22:02PM -0600, David Ahern wrote:
> On 6/27/23 6:44 PM, Bjarni Ingi Gislason wrote:
> >> Running checkpatch on this patch will show these things.
> > 
> >   Here is a simplified patch based on the latest "iproute2" repository.
> > 
> >   Output from "checkpatch.pl" when run in the "git/iproute2" directory
> > with the patch:
> > 
> > Must be run from the top-level dir. of a kernel tree
> > 
> 
> Add '--root /path/to/kernel/tree' to checkpatch.pl
> 

  Thanks.

  Found the right argument for "--root".

~/src/next-linux is a link to "linux-source-6.3.7-1" (from Debian testing)

/home/bg/bin/checkpatch.pl -> /home/bg/src/next-linux/scripts/checkpatch.pl

checkpatch.pl --root ~/src/next-linux 0001-iproute2-man-man8-tc.8-some-editorial-changes-to-the-m.txt

total: 0 errors, 0 warnings, 215 lines checked

0001-iproute2-man-man8-tc.8-some-editorial-changes-to-the-m.txt has no obvious style problems and is ready for submission.

