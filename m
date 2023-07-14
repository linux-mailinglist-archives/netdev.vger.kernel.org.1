Return-Path: <netdev+bounces-17798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593D97530D7
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EC9C28203B
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D738C63B1;
	Fri, 14 Jul 2023 05:03:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F733FEF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:03:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B05B2D5F;
	Thu, 13 Jul 2023 22:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=vYGgiwi6McTgXJVwB+z2H4GZagJiz++rZZuJFwVAhog=; b=11Cfc2grFTHW81PM4huphD6u7b
	7QtstLh0AoPzH3AQqSgr3qBsnaE2oKv7wkOZnYtB3gvjGyqI1FoHGfsa8aLKPOWBhWZXWE5M9hfKd
	FTqqraHGvq/6ItQ9wW5b7z5/naEvQOvruHKx0wcXJDVBc5YmWYGWHUHLxXoKyYFBnTUPhQrUeGWRu
	n4lXZLvuOWjem1ymtqd1onFp+53dtvX6jSYUrqkiduU2lyoxtjrmfbwEC1hRX1WfEtxLybe6GamjZ
	dgLiKh5jQ6fy38Z0mHzA+3hWWpouZKt61qyxQSaPjTov+msGAdXBMZ6sM8W4bDRryY2ruhkyKC2sh
	IbzOBd9Q==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qKAxY-0051qn-0O;
	Fri, 14 Jul 2023 05:03:16 +0000
Message-ID: <d5727371-e580-a956-7846-b529f17048ca@infradead.org>
Date: Thu, 13 Jul 2023 22:03:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH docs] scripts: kernel-doc: support private / public
 marking for enums
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 netdev@vger.kernel.org
References: <20230621223525.2722703-1-kuba@kernel.org>
 <399c98c8-fbf5-8b90-d343-e25697b2e6fa@infradead.org>
In-Reply-To: <399c98c8-fbf5-8b90-d343-e25697b2e6fa@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jon,

On 6/21/23 20:10, Randy Dunlap wrote:
> 
> 
> On 6/21/23 15:35, Jakub Kicinski wrote:
>> Enums benefit from private markings, too. For netlink attribute
>> name enums always end with a pair of __$n_MAX and $n_MAX members.
>> Documenting them feels a bit tedious.
>>
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks.

I have a need for this patch. Are you planning to merge it?

in current linux-next docs build:

../include/drm/drm_connector.h:527: warning: Enum value 'DRM_MODE_COLORIMETRY_COUNT' not described in enum 'drm_colorspace'

That enum identifier could/should be marked as private:.

Thanks.

> 
>> ---
>> Hi Jon, we've CCed you recently on a related discussion
>> but it appears that the fix is simple enough so posting
>> it before you had a chance to reply.
>> ---
>>  scripts/kernel-doc | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index 2486689ffc7b..66b554897899 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1301,6 +1301,9 @@ sub dump_enum($$) {
>>      my $file = shift;
>>      my $members;
>>  
>> +    # ignore members marked private:
>> +    $x =~ s/\/\*\s*private:.*?\/\*\s*public:.*?\*\///gosi;
>> +    $x =~ s/\/\*\s*private:.*}/}/gosi;
>>  
>>      $x =~ s@/\*.*?\*/@@gos;	# strip comments.
>>      # strip #define macros inside enums
> 

-- 
~Randy

