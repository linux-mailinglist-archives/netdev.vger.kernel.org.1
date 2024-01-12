Return-Path: <netdev+bounces-63244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66E282BF38
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099E21C2366F
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512FD67E7E;
	Fri, 12 Jan 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl9cKD6C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B286867E6D
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705058952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AbkLOlZQBQsF8MXJlHbM6x1QpuwajGvznNTWfBlc/wU=;
	b=Nl9cKD6CY8IbPeR6dVSYR35cJ6L/+3PiQyWWWqSu1+kL8CMNLhJJqol+/M7V1LlpC8Zgon
	cRDZuDiR00X4PVEIIhz1dLF7WuyAnqmBAvu/7hsiY+CCoAnKpojsggOahIXC+eUiZMa25x
	MyedFpKuwMe8nhBm13IqxZ5aqpIsMFg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533--U7xvEqQMEi6ewjV21ZcSQ-1; Fri, 12 Jan 2024 06:29:10 -0500
X-MC-Unique: -U7xvEqQMEi6ewjV21ZcSQ-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6da380cc0d6so7515424b3a.1
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 03:29:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705058949; x=1705663749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbkLOlZQBQsF8MXJlHbM6x1QpuwajGvznNTWfBlc/wU=;
        b=hjTulvWD0Jn5RR9R5tYUfj9e9vPLP83J76leoh1wNXatrs5nng97jmbZydtn1aQaG8
         6kEnVdIqftd5KiGdeGpIdRZIgPZpkhlClIQVXQjEHPWikBas0K58I6AkM4Nf6X70pbHv
         OrXJuCrkEH+c+LhM40Uly7KXBNTrbI77TfBgoolPA52mo8+vsFDx/8T/e1bUPmjiDxBN
         QXBHpH4n7q3Wmis+C+KjUnzWHf9KCzLglhJKBaoZwL5OYK/MjHFMeFRmACa4+wlG0XZH
         rR139n5DA98VBL8bUi9gz85pHGFrEIgjrvErfZWQ8eLj/qLNDLz5J6vAbSpkORWFWdJ8
         X5bA==
X-Gm-Message-State: AOJu0YyzRUiGL0XjAFplmn0nRnFHJEF0ZYkGe1zkqXEVf7N2zdofb15a
	BnR4SIdBXooYwPtf+vx4Ue3iLi36sHlKW4lywycRDNce7F7yE8P+Nkb3HpwkzOR93gy4us3lD1E
	Ph0aMG9+zy3XmIb7JADTiysSEx/CcHuxV
X-Received: by 2002:a62:d10b:0:b0:6d9:bef5:f6c with SMTP id z11-20020a62d10b000000b006d9bef50f6cmr800056pfg.13.1705058949178;
        Fri, 12 Jan 2024 03:29:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO97fzETGtRysRnJ21dLW75pY45kOfhnjqATjhrTYiMQgB7peWnOfOtCOJiL8sV5cusCdkIg==
X-Received: by 2002:a62:d10b:0:b0:6d9:bef5:f6c with SMTP id z11-20020a62d10b000000b006d9bef50f6cmr800044pfg.13.1705058948801;
        Fri, 12 Jan 2024 03:29:08 -0800 (PST)
Received: from localhost ([78.209.94.35])
        by smtp.gmail.com with ESMTPSA id u25-20020a62d459000000b006db056542e6sm3075024pfl.190.2024.01.12.03.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:29:08 -0800 (PST)
Date: Fri, 12 Jan 2024 12:28:58 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next 0/4] documentations cleanup
Message-ID: <ZaEiejXKx8MOhmNt@renaissance-vector>
References: <20240111184451.48227-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111184451.48227-1-stephen@networkplumber.org>

On Thu, Jan 11, 2024 at 10:44:07AM -0800, Stephen Hemminger wrote:
> Move what is relevant in doc/actions to man pages and
> drop the rest.
> 
> Stephen Hemminger (4):
>   man: get rid of doc/actions/mirred-usage
>   man/tc-gact: move generic action documentation to man page
>   doc: remove ifb README
>   doc: remove out dated actions-general
> 
>  doc/actions/actions-general | 256 ------------------------------------
>  doc/actions/gact-usage      |  78 -----------
>  doc/actions/ifb-README      | 125 ------------------
>  doc/actions/mirred-usage    | 164 -----------------------
>  man/man8/tc-gact.8          |  85 ++++++++++++
>  man/man8/tc-mirred.8        |   8 ++
>  man/man8/tc.8               |   1 +
>  7 files changed, 94 insertions(+), 623 deletions(-)
>  delete mode 100644 doc/actions/actions-general
>  delete mode 100644 doc/actions/gact-usage
>  delete mode 100644 doc/actions/ifb-README
>  delete mode 100644 doc/actions/mirred-usage
>  create mode 100644 man/man8/tc-gact.8
> 
> -- 
> 2.43.0
>

Thanks Stephen.

Acked-by: Andrea Claudi <aclaudi@redhat.com>


