Return-Path: <netdev+bounces-68776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D62847FF4
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04FA282D76
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62766F9CD;
	Sat,  3 Feb 2024 03:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UaYR7fgp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YPkQq+tH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07C1F51B
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932037; cv=fail; b=s9xpLfwePe2tIjuofB9IutfIH10BnJCxDM7ddRsCu1ZlYZumkMKm5uRu7EBdvm7wx6tMI6bnuxW48jr6gmtSq46Bf5mx5LMqL/eqaWBiLiCCHwckaHZ/8rAHvHOU4ragE7g/1U0bd5EBisEbrXRlgZJAlWaxXAx3438NCzmmYbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932037; c=relaxed/simple;
	bh=amiQQEZ+NkoeUQdsh7rTY8mXNA41cL9Oy3l1UfeCWlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SbdQHo6hKtm+SdSWZGqKkkMSizauwcQLT5BcbK8t8x3MvMreImX21j9Ol7caJsHZqo4aPEDmdF+CEA6iBqf2KHD7nbGbP67lyfBRgLHeub5DzHWFuB7xENZT3BqSeFEQfn6cb89VVyhMkvu0PefLPo0eIPMLK8pH/M4QwmYQJFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UaYR7fgp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YPkQq+tH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4131voAU030453;
	Sat, 3 Feb 2024 03:46:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=amiQQEZ+NkoeUQdsh7rTY8mXNA41cL9Oy3l1UfeCWlw=;
 b=UaYR7fgpJTXCBlWRIW5mXopVa8TlI82F8NyCqUNjBq/bi9fUZMZy6rn/cQmvv2ZXmYgm
 McyqiRkrCEIEOF7SPQoOzOnO0cZ3wTAV7IA+jiUbcXmKPFtgfu6tovLy6tlDyA+qWCGN
 +/gpbfk7du7UZSd1/yuo0qeNcqXw3uNo5c48qZKtq5mPwqWTmSZh8b8c44FuaaTG/Ie0
 95DzJ37f1qRrUYZyrEbB65Sa196LD3bUZXnjC5qAHX06q02hQVXXFOVKx9jZ3AENZ/97
 Q7nbUh72EGk+2f/q6yadC+LCqFdPYy62O2a9tyHT/glcmVE0Z6cyyVCt88EBl7KudJOK yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c93r3ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 03:46:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4131XPe4038305;
	Sat, 3 Feb 2024 03:46:55 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx3av7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 03:46:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JH0eAzMnvF2q0lSsITWqeXOq173DtgXZWh+WdPD1CTvAG7+Wtra8NVaDCzc+Fma1rAH9wJgWtIrAxGeiJJxLlEM9MOy0ulBDaoQfIlHwRt+rC0brmMGCsVSJqdikx6TANsWoqmBBofMYDnBSvRN/82UWGFnr4J5uAHYkAD3xPEYlAWXfkYG71+a4P1Jej1x5/mDlTGXY+z6Z8QtWhm4aQyt1Eg5u0hvuP34715F78QkZscKits6xwPbtN3sXCEADiwd7FP7/kP0GlpKFe5tVyguZkTr5MvCr/qvGCrj0gSIwT9w3uBSGghdPxkUcsgSWZhhIRSagU7rtX5MtMVc2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amiQQEZ+NkoeUQdsh7rTY8mXNA41cL9Oy3l1UfeCWlw=;
 b=JygVb383EMrJKny3x7tYCTgFAvE5FRmSKuhO/C29OgJ1XQGWvRtKYVlyYOUaMzMbPglpsQwk4MsqOGlq2NPNpLPo8bUH0C4d+axONOa8mG1sxEoQSIZI2I6QvwJByVzWIo8sNkitzPOLg/2NJfO59f6axa4AwVlLysLHa6rpItS8gpqCp3FojMK2GV4tXOClmU1LH7r47EmF5ZTF0/kyQugAp8YFsngYPwZs6YEwQwugQhwc3CufMVWsCnN2ov4jKxfwZtwhV2ck+g1dwR8mbKa0zF216/briTxStg3m43iODlok6iF5ce8UBeB91A89nz62X6+kEFMdhA6QOp0dCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amiQQEZ+NkoeUQdsh7rTY8mXNA41cL9Oy3l1UfeCWlw=;
 b=YPkQq+tH7LWUCZh5R+4it7kPTod7iPq8mjg9McFWNE2Xpr9v5RKhnTBmQcCJk0N6f4F0ceEX7OEOsVaRkjt8IUHi160AcYOZFTJ/VuJXZ6MJHBqOA7IcojE3AeADmVF1GKc7RscQAfmdCbLnHDi5vSA/K+fbOnEjz/C++RBSnUg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ2PR10MB7583.namprd10.prod.outlook.com (2603:10b6:a03:537::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Sat, 3 Feb
 2024 03:46:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ed:9f6b:7944:a2fa%7]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 03:46:51 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: Jakub Kicinski <kuba@kernel.org>,
        kernel-tls-handshake
	<kernel-tls-handshake@lists.linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: Persistent problem with handshake unit tests
Thread-Topic: Persistent problem with handshake unit tests
Thread-Index: AQHaVfxCzc2/knji+0CT6+WwDMzkKbD3bnAAgAAYQICAAABtgIAAdBsA
Date: Sat, 3 Feb 2024 03:46:51 +0000
Message-ID: <3C9375EF-D773-48CF-98D3-920B33E02F5A@oracle.com>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <20240202112248.7df97993@kernel.org>
 <f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
 <39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
In-Reply-To: <39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ2PR10MB7583:EE_
x-ms-office365-filtering-correlation-id: 4b453b88-9301-42ad-2ffe-08dc246ac19b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z/qjEY6pF0OuC+JmeTyhLQDKYMBGLRkXApYhovbWZs4iPKTiwN0jHc4enLtlrhOWPukFBredUqvUQZqph4Slp+eSo6/AK8WyfbQWhTqEQRVstcNVYZZGUBMP2n0vyRU4TQXHGl6OklPQH6V/CJ9bFn3FWbVpJ4gAVQzIaLStG0rhEn4gccjHDbvpqc6D7Vfry7+TpDaiz/LV3ZGzHO3PxdBneR/vMd/CoD6Eopiv17yIueNAJK/CyBGpKxMXOOBPnmetCJIEtq/wzDayvOJM/EjscY24E/bQnXjlyt9uh1puYUqHhdn7DmTVcqcXB9WFyzCmDEK3p8JS8NnoGLkvheNfb21EMQ1oTB9NnutebfRfJB/YjEL+n2oMhYshIOz71i7G+MVLg3k2w8UhnvTmSSNbQhh/5IuSmz8rI8tQdZLA8dXbbu5YSMWjvDDN0QTjQcU90D5PhPCsp9hHMRwzumz/9ZOnRe7q6pv1Lc2J1HPELbborgF3edrGwKQlcHaXtIMg8Ek8uYALNIrJkDGh/nRbBkVWMP3jZEkaRhf8VVLuZ6HFWD2DKEHHcEzf6D3n3SzATYezlPF5Wa2zuDEFOIj0HcS7XWfoBa7Rb98Ou9oA/4rVJLCU+3L8RDnFt6SbAqckJhVBMhEJbMmGp1j1gQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(366004)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(5660300002)(66946007)(8936002)(4326008)(8676002)(6916009)(54906003)(316002)(64756008)(66446008)(66476007)(66556008)(76116006)(2906002)(53546011)(478600001)(6486002)(33656002)(6506007)(26005)(38070700009)(71200400001)(36756003)(6512007)(2616005)(86362001)(83380400001)(38100700002)(41300700001)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bG8wdUJDMG1tMkpPYXpWTExBOVRZRXk1Q0JRY1JSUkROVkpFTnFDSTJRbUUx?=
 =?utf-8?B?UVkxeGNmVC9QME9PVW41a1BiYnk5eGNkT1FJTG5TQ3RnMjVsa3oweGFTWnNE?=
 =?utf-8?B?VENmUG9kTERFdXNVTUtndU1jZkE1RVVxbXVnVXYzakNiOS94SkVVT3ZMNGI3?=
 =?utf-8?B?ak9ZSmc2aFNOeVNCT0Z6WHloNTlhRnNOZGZIMzhnVUY3anYrd2xQYWFlT0Fy?=
 =?utf-8?B?MDRDanVFNUlRVWwrNVd6REc1b0RVaEd3UXI5UXhiUUwvdS80MzlJVnR3VDgv?=
 =?utf-8?B?UjJuT3dXbGsxUFE4WHlCeGRqMWdIM21zQ1dMeVZEMGJSVXUyd21hRXpjTjM2?=
 =?utf-8?B?OGpPdVVidHY1cFo1ZjlLektDOVBDUmlqREE2NkQzb0E4VnlDR2JaTkJSWDQ5?=
 =?utf-8?B?aDI2dnA1c2k0dGwxdEt1SDNNc2FLb1l0RHlDQkNPejZqblRHTUxZRnJ6N2JP?=
 =?utf-8?B?bmlsVlVvaUxORDJPUkRWcEZXNGhNZFVFZjl4c1ZXZ0F6UEJ1VmJ6dzhSYzRE?=
 =?utf-8?B?UHgwK3I2U1NwYndkcWRPazlRMm9FM3cvMWQ4S0RNbXJvUlNoMHJIbFFLeVFE?=
 =?utf-8?B?N2hLdktQTnVpWWhaS2NWdURYSE1WczB0T0RJdTd1SkxpYWVmck9ZMXoxNEdt?=
 =?utf-8?B?MTRmd0hORGErc3JIcGcwdTJXOE1mYWVzK3Rvd3ljWHJwTjJaVk5NQy8wY3Mv?=
 =?utf-8?B?cnk5bDl6T0R3MzFDN2U5eHZiOWNaYzg2T3FwTWtlMjlxNlJ6Ui9YK1hReGFp?=
 =?utf-8?B?aHE0UzFOSDhuemFGMjk2NjA3MVJLOTFGdCtKd0FKTXlQNnZENHNyTHhobERp?=
 =?utf-8?B?REx5aXRNUXExSzRoVGgrek9pL2NaZUNlN0loOUtXZW5pd3Zwd2c1WGpTNllu?=
 =?utf-8?B?eCsvcTZ2aFNTVDh4WERqWTFzeUVqdkUxR3R2OEFMMERIbHBiL1g1cFFia0VR?=
 =?utf-8?B?Qi9MaUtQckpCdkRZZlpIRTd3N3M2cU5HS1VrNzNGN3h0YjBNVGFvV3lSQnV6?=
 =?utf-8?B?ckFjTTd0L3A2OFFFSjdPWndYRzBNRHRkOWFVVlcrM1llRDVmbU82SWZGOStz?=
 =?utf-8?B?MEVRY1pzR3BNL28vcFNxNG1JZERMdnREVHhhcktrUGtUQk5VYXYvbnQ3QnZD?=
 =?utf-8?B?Ny9KQWJUNmp3Mjl5M2x2U3hIblZXdWh5dC9PYlNacmdOT3dyVlBmSE1IY2Rn?=
 =?utf-8?B?Qy84cnRWUmtrMVZ3RTllV3JrK0QvWDhFdHgzY1JsalFMc1BBYXFnbUJyNGR5?=
 =?utf-8?B?MVBTSkVFNmk3cHJobVhzQ05SalhlaElRL2wxZmxWNEZuRlBQWWdtWGJUb3ZE?=
 =?utf-8?B?cWdKTG9aVCtmbDMyOVhhS0FlTkI1TDJHYUgzZWRPckhQVHl5d3lQeXJUTHJJ?=
 =?utf-8?B?aFhSL3dCdlRjbHd1YTJ3WmVISzgxcExPbTNqUFFtRElLeEFpNkNWejQxbSt5?=
 =?utf-8?B?UW5KWWN4TUxjRTh0bjBFb0RMbFk3UjFrSGpxSXF2a0pFNkhxWXdHZ0JKak9n?=
 =?utf-8?B?dUdLMWI1bGp2WlVzR3ZxcFlvMXRyVVZHZDFxaE1vWlgrVWsyS1I1QTJOeVVu?=
 =?utf-8?B?T0x5WkpBcVRyMVJ3MnRLOEdWTWMwWXp0QURxTjBRbkVXRXd6K0JBZUcvbmxY?=
 =?utf-8?B?MXkrVU9TVzlUOHJ3bVl4OHhnRUg4ZC91ai93OEdYdkVicmNUSXF3c3dNVWZl?=
 =?utf-8?B?dnVaYk1OWTR2QVBJTkJWZkZ4SmVCVENGOHlIQkxZbGRqeFNBbVl5a2FTTGwz?=
 =?utf-8?B?SnRlSEhka0w0L0dMUEt1Wk1VbWRyL0U0UkJWcUZYVzNYQ0dKVGR4Z0w3OU9n?=
 =?utf-8?B?dkpKUWMxQ1dhTnFXRkhvWFFtdDJqY2hoNWJmNjVGdkJ5MkY4YUl3STgvTFI3?=
 =?utf-8?B?M2RneVcvSWp6anJHaHZIRUF1MW1UOGlDZW16MHN5UFgvdHVVQkZOUkNmbm5J?=
 =?utf-8?B?ZFU2WnZ1U2xIT3dOc0RNRW9lUjlSZDJSZThZZUtRUTg4MkZIVkFYOTNZbHRP?=
 =?utf-8?B?bDBhaVR1RVdvT1k1QWNCMEt0ZWRrZ1ZuMjZYUTdldDhnZnFHQ3JnWldQcVBG?=
 =?utf-8?B?N1d2VDRscEJsWDhmaHg1aGNHZDVFS2Z3bFFkMEZSVmtPdldjTmZRaEdPZG1G?=
 =?utf-8?B?Ukp5R2VCbVYrZEV2bmtMaGFiUTVnUlF6VDV3QVB2cGtZaWdhYkpQMWZtMU42?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14878E100DFDE843B10A9295CC8C5AA0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TxyGgJP2bU5XFrjg+u42gHZ/cTnmw3Bu8cE0QkuY8uD7noNG0o2bkf40naOaKRgEkHJUYY7fvd0afLkbtGtUkP9C/Ac+FvlVMLpzJujF+bIiQiZojMqInJqN8aHb8XYE8EKCcISYQEejaxfqaYLNGfLRUPyusQg313KNeJEmYx2rrnoe+7C4fqwp18ZGv3S2eFHTLx1lNjdDk58qO07bBudWwICVEYg1UZR06Fc9BA50kn1PzqLZ5dmGVmAROnQ8s1eSf2zOwWHiCMZWrs0EtxUH47aVkMa9xluS0CDN1SIM5eQPMgW0KrMrVKJ1m5MtrwW4kPJWCFdh5Hl5cTlhnuunaaM9QgFLKbnCoDpn4rxsjSEjO4R6vf/Kg9PWZ+hy1VnbxfAslyRtY1J7eBIdVAWxkDIpmRh+nHd3+QD0xm5dSoEKgX5U3iBPGck1a5kLLN7z72NaNcFmF/JySejjeZOKhXQFMvAMC8LL4n8gBDB4r4CgkpgCRmWdnN1JuRjD13djA78ChuaMkkYjsX60z4H+38/udBGZYpjHw2p9wh5xF9O5F9efD6OwvXyn3gjCx5ewMz/KKFnzFDJ3KfyJYsyECvFz02JSgPUvYBwdx78=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b453b88-9301-42ad-2ffe-08dc246ac19b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 03:46:51.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: irUFSqz7A0a9H9N+8WcnTkc6TUhI4vIm+5Bfxgl/6bywvTvOKw+t+f88F9936BMeo5IcyAJR6yYSeluIYZAF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7583
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402030023
X-Proofpoint-ORIG-GUID: JJ2kLf2FkO1a-DMN_3GJXX9fYSP5IWYP
X-Proofpoint-GUID: JJ2kLf2FkO1a-DMN_3GJXX9fYSP5IWYP

DQoNCj4gT24gRmViIDIsIDIwMjQsIGF0IDM6NTHigK9QTSwgR3VlbnRlciBSb2VjayA8bGludXhA
cm9lY2stdXMubmV0PiB3cm90ZToNCj4gDQo+IE9uIDIvMi8yNCAxMjo0OSwgR3VlbnRlciBSb2Vj
ayB3cm90ZToNCj4+IE9uIDIvMi8yNCAxMToyMiwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+Pj4g
T24gRnJpLCAyIEZlYiAyMDI0IDA5OjIxOjIyIC0wODAwIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+
Pj4+IHdoZW4gcnVubmluZyBoYW5kc2hha2Uga3VuaXQgdGVzdHMgaW4gcWVtdSwgSSBhbHdheXMg
Z2V0IHRoZSBmb2xsb3dpbmcNCj4+Pj4gZmFpbHVyZS4NCj4+PiANCj4+PiBTb3JyeSBmb3Igc2lk
ZXRyYWNraW5nIC0gaG93IGRvIHlvdSBydW4ga3VuaXQgdG8gZ2V0IGFsbCB0aGUgdGVzdHM/DQo+
Pj4gV2UgcnVuOg0KPj4+IA0KPj4+ICAgICAuL3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXQucHkg
cnVuIC0tYWxsdGVzdHMNCj4+PiANCj4+PiBidXQgbW9yZSBhbmQgbW9yZSBJIGZlZWwgbGlrZSB0
aGUgLS1hbGx0ZXN0cyBpcyBhIGNydWVsIGpva2UuDQo+PiBJIGhhdmUgQ09ORklHX05FVF9IQU5E
U0hBS0VfS1VOSVRfVEVTVD15IGVuYWJsZWQgaW4gbXkgY29uZmlndXJhdGlvbi4NCj4+IFRoZSB0
ZXN0cyBydW4gZHVyaW5nIGJvb3QsIHNvIG5vIGFkZGl0aW9uYWwgd29yayBpcyBuZWVkZWQuIEkg
ZG9uJ3QgcnVuIGFsbA0KPj4gdGVzdHMgYmVjYXVzZSBtYW55IHRha2UgdG9vIGxvbmcgdG8gZXhl
Y3V0ZSBpbiBxZW11Lg0KPiANCj4gRm9sbG93LXVwOiBJZiB0aGlzIHRlc3QgaXNuJ3Qgc3VwcG9z
ZWQgdG8gcnVuIGR1cmluZyBib290LCBwbGVhc2UNCj4gbGV0IG1lIGtub3cgYW5kIEknbGwgZHJv
cCBpdC4NCg0KVGhlc2UgYXJlIHByZXR0eSBzaW1wbGUgdGVzdHMgdGhhdCBzaG91bGQgcnVuIHF1
aWNrbHkuIEkgZG9uJ3Qgc2VlDQphIHJlYXNvbiB0byBleGNsdWRlIHRoZW0uIEdlbmVyYWxseSB0
aGUgbWVtb3J5IGVudmlyb25tZW50IGluIHRoZQ0KS3VuaXQgdGVzdCBoYXJuZXNzIGlzIHNpZ25p
ZmljYW50bHkgZGlmZmVyZW50IHRoYW4gdGhlIG9uZSBhdCBib290LA0Kc28gcHJvYmxlbXMgbGlr
ZSB0aGlzIGRvIGNyb3AgdXAgZm9yIHFlbXUgdnMuIGJvb3QgdGltZSBvbiBvY2Nhc2lvbi4NCg0K
UXVlc3Rpb24gaXMsIGhhcyB0aGlzIHRlc3Qgc3RhcnRlZCB0byBmYWlsIG9ubHkgcmVjZW50bHks
IG9yIGhhcyBpdA0KYmVlbiBicm9rZW4gc2luY2UgaXQgd2FzIG1lcmdlZD8NCg0KLS0NCkNodWNr
IExldmVyDQoNCg0K

