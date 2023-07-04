Return-Path: <netdev+bounces-15265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B17467B4
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 04:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADC1280E15
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 02:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3E439A;
	Tue,  4 Jul 2023 02:48:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22555181
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 02:48:40 +0000 (UTC)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7632DE64
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 19:48:37 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-262e5e71978so3180269a91.1
        for <netdev@vger.kernel.org>; Mon, 03 Jul 2023 19:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688438917; x=1691030917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qx9CJG2oEknqYh0BmONqCpo6BfGi9TDzs0UtddbREs=;
        b=I4MNS5K8AGIcTLwonJ4iRrdB6XGmNVQsNxclsISWa95W5ZYNlsORFPePDEov7Zf8X/
         s9C35eYk8lb8KNWbLsnR4qYaVP27ckXBH1sFby4al3pZu7WaxGap5J73DfaSlqoXNUj1
         niet00xCY2MlF3lrpRVrVCLDqOheMM/E7UyI4MKVsye/59ilNMf9HizEMJj89yjWs0TT
         2N+T/8FyOZXN/o8I9CJvQ3u3AYjsMItDp8plXkN12VVvPiYxUPdQf1/gqPQL3bzX1fNt
         8ZwMWz14Fdf5MOcCl4om4pG5IJgd4tHqQ4eOKUo1g0WYzNPog5M+yS62N86E79Auvb9K
         2MEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688438917; x=1691030917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qx9CJG2oEknqYh0BmONqCpo6BfGi9TDzs0UtddbREs=;
        b=hx+ioKSwFuM/LoDkn7BsRNovVV9SKA2nPlROvW+m7fxXAIVNlywc5VzY+vCT3BtnTb
         vwr6W4CgERac4LfTq7Dkbz9wNNn9HzVIKdG32Mc2B0TCmrN7zfiiUdu6HxIZGdWRKA50
         B/moZfJ0XGtKprUObnfWK6scFiABZ0sAOx+XrpFMBzvZW04mG0WkYalmZqT5iFUxNZbw
         x4ELIXiWM7ClbzpTTvFV8bG+6etWOyOIhVZ6txxzWyI42mrpI/9NiIr39PSecWXoncU9
         ERFYOCWxqeNRUayvePG8MsR0cPCdoEP1GxLMHDr6yC+UXuodgkig31WZv403pPifsx2L
         v/bA==
X-Gm-Message-State: AC+VfDxGMbY2hk140OOO6lp9Sz49xBMGz6XMDNi4ihyVHpe2X8CqxAvr
	nv8A+iJKUEIExMeKr5Fk5yQ=
X-Google-Smtp-Source: ACHHUZ6fVEyCjJXSebkvO0GedsTEuDaamlJD99XwW7g+s1vxDnxRQ4uDjpPggvmqAdbP8SVC/LnrDQ==
X-Received: by 2002:a17:90b:1e0b:b0:25b:f105:8372 with SMTP id pg11-20020a17090b1e0b00b0025bf1058372mr23643019pjb.5.1688438916880;
        Mon, 03 Jul 2023 19:48:36 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id oj3-20020a17090b4d8300b0024e4f169931sm17797030pjb.2.2023.07.03.19.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 19:48:36 -0700 (PDT)
Date: Tue, 4 Jul 2023 10:48:32 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: paolo lungaroni <paolo.lungaroni@alumni.uniroma2.eu>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"stefano.salsano" <stefano.salsano@uniroma2.it>,
	Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
	David Lebrun <dlebrun@google.com>
Subject: Re: R: Why we need add :: at the last when encap seg6 with inline
 mode?
Message-ID: <ZKOIgDp4DIXV2Aj4@Laptop-X1>
References: <ZJqPg7Ck8ulDp2f+@Laptop-X1>
 <AM6PR07MB56691CDB704895F0E13689AA9125A@AM6PR07MB5669.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR07MB56691CDB704895F0E13689AA9125A@AM6PR07MB5669.eurprd07.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Paolo,
On Thu, Jun 29, 2023 at 10:57:32PM +0000, paolo lungaroni wrote:
> Just for the sake of clarity let's consider Example 1 where the SID List is
> built as follows: <S3,S2,S1>.
> 
> Before applying H.Insert
>    IPv6 DA=B2
> 
> After applying H.Insert:
>    IPv6 DA=S1 | SRH <B2,S3,S2,S1>
> 
> In this representation, we stick with the draft conventions where the SID List
> is represented in the reversed order. That means that S1 will be the first SID,
> S2 the second one, etc. B2 is the original IPv6 DA that is pushed into the
> SID List and will be restored once the SRH is removed.
> 
> Now let's consider the H.Insert implementation in Linux.
> 
> User space
> =========
> 
> Currently, when a H.Insert tunnel is instantiated the userspace (iproute2, in
> this case) acquires all the info (e.g. inline, segs, etc) from the CLI and
> builds directly the required SRH header [2].
> Considering the H.Insert tunnel (i.e. inline mode), parse_srh() (line 894)
> accommodates for an extra space required to store the original IPv6 DA (i.e.
> B2 considering the Example 1) which is not known at the moment of the tunnel
> creation.
> For this reason, iproute2 fills the reserved space with 16 bytes set to zero
> (and that's why we see ::).

Thanks for the explanation. Compared with dealing each segment route and
adding the original DA in the middle of struct ipv6_sr_hdr, this way looks
more easier. Although the users may feel a little confused :)

Regards
Hangbin

