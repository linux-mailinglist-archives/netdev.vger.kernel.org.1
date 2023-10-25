Return-Path: <netdev+bounces-44153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F09A7D6B07
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 14:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135F9B20D62
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193B61F607;
	Wed, 25 Oct 2023 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vcD/k8GC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182222D604
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 12:16:46 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289C137
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:16:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-507b18cf2e1so7632117e87.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698236202; x=1698841002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l6enL5EbyDfVL6+C+BZSR7yee3p77mBvqCgXCd423pQ=;
        b=vcD/k8GCRaQ1ThDJ7LoedY/ON0NLKdVNmvkYYP1V2q0Tk8rDm3izvg7MrvKKmVQ7st
         WHGCqZO1qLjwPpaO6Z4Q805mCQmAOESt5PCEMU9iaWTq3S7ce855ZV1nssN7VB24U6n0
         37v1Es7URZt1gsMQBJP+su4xP8x/4iW4rJfzbmm3tyLKAH3mCi7K4/WOefAMeLREp+So
         ulNapVkkv4h75OqEROeoXjSL3J73yseZKG48PQU8kdQZkc737aok4NanCLTE92B0nTlR
         LUzrL+NHKL/Nh+00pa9hiO9XO6KtLvhTtMA5I7DIPlxQa2witTB7E3cJoWj9Latfupbq
         bN3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236202; x=1698841002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6enL5EbyDfVL6+C+BZSR7yee3p77mBvqCgXCd423pQ=;
        b=Kk8wpWev1MXW6mGNR+u3h5JAFZaovaU8yOzIssd8IvgrrW3kNo11diFszVt5Mnt/4a
         aI/E/WcV0OlrVeifLjl8KOPUPviItdkXmGsBCZZrpoI1ghNhgDxPf8yt35XW8igA9oAv
         BwI+8J7N5t6JV0xlMis7EWKmTmrmBlPskjuP/XIIQCTwuTc/eaaPso9jpDrVu0rzqOUf
         40qlw5CRzgIyQM4EkMm9KFJlZdRUyYyU5WGqIKUUxP3OrXVWmRT4Lsz5e1Mg3WpdTjKG
         y7mVvMk2nW/UNCtNNg7FgMKrVar6l2/eGoobi/A9t5L/cdunOS7qntmu4A7J89vvJ+8C
         rO3g==
X-Gm-Message-State: AOJu0Yz91Icb9f3plrbcMPyHjMZCHDrYMUcibKgCHLzqbcT3xY9xLhMQ
	TAKC6AJICkap/AepTzz/DHNQ4w==
X-Google-Smtp-Source: AGHT+IEFA6aHGTY5ZaZDxLfpdX+ICUrYbRcgGlM172dy60d4sgJiuydb3ODCVjhW/oUznlxvfDMtJA==
X-Received: by 2002:a05:6512:2356:b0:507:b14e:b10d with SMTP id p22-20020a056512235600b00507b14eb10dmr13201259lfu.66.1698236201634;
        Wed, 25 Oct 2023 05:16:41 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id b24-20020a05600c06d800b004064e3b94afsm19103500wmn.4.2023.10.25.05.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 05:16:41 -0700 (PDT)
Date: Wed, 25 Oct 2023 14:16:39 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Message-ID: <ZTkHJ6IP4tj3EmCV@nanopsycho>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
 <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a8f54a8-1a18-4797-a592-b57bc6fc45c1@intel.com>

Wed, Oct 25, 2023 at 12:48:37PM CEST, wojciech.drewek@intel.com wrote:
>
>
>On 25.10.2023 12:33, Ivan Vecera wrote:
>> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
>> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
>> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>> 
>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>> ---
>>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>>  2 files changed, 10 insertions(+), 31 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> index 29fc46abf690..896c43905309 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
>> @@ -17,29 +17,16 @@ static void i40e_resume_aq(struct i40e_hw *hw);
>>  static void i40e_adminq_init_regs(struct i40e_hw *hw)
>>  {
>>  	/* set head and tail registers in our local struct */
>> -	if (i40e_is_vf(hw)) {
>> -		hw->aq.asq.tail = I40E_VF_ATQT1;
>> -		hw->aq.asq.head = I40E_VF_ATQH1;
>> -		hw->aq.asq.len  = I40E_VF_ATQLEN1;
>> -		hw->aq.asq.bal  = I40E_VF_ATQBAL1;
>> -		hw->aq.asq.bah  = I40E_VF_ATQBAH1;
>> -		hw->aq.arq.tail = I40E_VF_ARQT1;
>> -		hw->aq.arq.head = I40E_VF_ARQH1;
>> -		hw->aq.arq.len  = I40E_VF_ARQLEN1;
>> -		hw->aq.arq.bal  = I40E_VF_ARQBAL1;
>> -		hw->aq.arq.bah  = I40E_VF_ARQBAH1;
>
>What about removing those I40E_VF_* defines?
>This is their only usage here, right?

Wait, do you suggest to use the values directly? That would be
wild even for i40e :)


>
>> -	} else {
>> -		hw->aq.asq.tail = I40E_PF_ATQT;
>> -		hw->aq.asq.head = I40E_PF_ATQH;
>> -		hw->aq.asq.len  = I40E_PF_ATQLEN;
>> -		hw->aq.asq.bal  = I40E_PF_ATQBAL;
>> -		hw->aq.asq.bah  = I40E_PF_ATQBAH;
>> -		hw->aq.arq.tail = I40E_PF_ARQT;
>> -		hw->aq.arq.head = I40E_PF_ARQH;
>> -		hw->aq.arq.len  = I40E_PF_ARQLEN;
>> -		hw->aq.arq.bal  = I40E_PF_ARQBAL;
>> -		hw->aq.arq.bah  = I40E_PF_ARQBAH;
>> -	}
>> +	hw->aq.asq.tail = I40E_PF_ATQT;
>> +	hw->aq.asq.head = I40E_PF_ATQH;
>> +	hw->aq.asq.len  = I40E_PF_ATQLEN;
>> +	hw->aq.asq.bal  = I40E_PF_ATQBAL;
>> +	hw->aq.asq.bah  = I40E_PF_ATQBAH;
>> +	hw->aq.arq.tail = I40E_PF_ARQT;
>> +	hw->aq.arq.head = I40E_PF_ARQH;
>> +	hw->aq.arq.len  = I40E_PF_ARQLEN;
>> +	hw->aq.arq.bal  = I40E_PF_ARQBAL;
>> +	hw->aq.arq.bah  = I40E_PF_ARQBAH;
>>  }
>>  
>>  /**
>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> index 9fda0cb6bdbe..7eaf8b013125 100644
>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>> @@ -64,9 +64,7 @@ typedef void (*I40E_ADMINQ_CALLBACK)(struct i40e_hw *, struct i40e_aq_desc *);
>>  enum i40e_mac_type {
>>  	I40E_MAC_UNKNOWN = 0,
>>  	I40E_MAC_XL710,
>> -	I40E_MAC_VF,
>>  	I40E_MAC_X722,
>> -	I40E_MAC_X722_VF,
>>  	I40E_MAC_GENERIC,
>>  };
>>  
>> @@ -588,12 +586,6 @@ struct i40e_hw {
>>  	char err_str[16];
>>  };
>>  
>> -static inline bool i40e_is_vf(struct i40e_hw *hw)
>> -{
>> -	return (hw->mac.type == I40E_MAC_VF ||
>> -		hw->mac.type == I40E_MAC_X722_VF);
>> -}
>> -
>>  /**
>>   * i40e_is_aq_api_ver_ge
>>   * @hw: pointer to i40e_hw structure
>

