Return-Path: <netdev+bounces-27303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2377B69C
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A4281018
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A1DAD59;
	Mon, 14 Aug 2023 10:25:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD68F77
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 10:25:08 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9858EE
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 03:25:02 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7jrj6003857;
	Mon, 14 Aug 2023 03:24:56 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kj5nbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 03:24:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=isOXBdNUV0KX1o+jCV0UQlMkTOCIw8hR7ktTpKbFIvbvT2iEluoYeTS2/1RDoT0RM5oPDQYqwTty67QI7uNqga/kHfJMYgl9G6hAzNM8nEoePIcdQl75TlSChDoMQ+url8nY3yBc0AeV0BQz3xUwDOly30dOCnrNiSpERRaZQp+q3+wOF14Uxlu9BWi1dPuqy1sh7X7/RvzWQvKqbTNTg725KWlgl0zni3azM15ZtsLYKaSbCeizvxYbpS7pVGDDmU0gyUiY3kUrMqOBLS66fKmTyKD/VQowFlfCftCcTlLiVGtGZo8U9POdaYmJ3kK1GurstGUFpZPv2xYUvrRH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oS8mT5XLO4sMihEhithbEPcbzCUpTHwSBphdjmn71dA=;
 b=Da0KcIxt0p6JrOlXMFwRyxNfa5UZ49val62qhlUje5E2+Lr+zEkGMcYO4t+OA5V0P0svoywPTrEr4IV1rXqgABUd/Q4UIIOyQ/jpotRwAKcCy7XufUTCtZ/xyQFNx2MMN6UQIFNrfXxIcI08W080b/cJ6XKKcQ1rIMhIM9xhYz3WIfBVutSYcQo8gbioz8G4q7stccvag5CulxgKNWkJE2g8hbJ78unTJK1PCE7iBLg157SuXbDDo9z8tmP/lsM43kG3Gn7ss7aTlYgrD52AgZDaaj0SHSxszuxHY3caboyw4BdPLAzYRLR/ecadWZiOaGbXNObAW+Lg0MKtL+f5yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oS8mT5XLO4sMihEhithbEPcbzCUpTHwSBphdjmn71dA=;
 b=I1YTOubFcqdBMqBuoSwz2HNpls5vhdUTtv8wglq5bof3L/xfgjsQzdJaHIfLolRCoBvNp8vSrEnjxjlr4gbckxpfgGGxiOZMC4Bj7WU/pJLcN05VbtF1W7AniAPs8ZKkEoyl912MXtBHQcw3AbXii7AJM85JjhPBsiz/M+4KfoQ=
Received: from BY3PR18MB4612.namprd18.prod.outlook.com (2603:10b6:a03:3c3::8)
 by CH0PR18MB4163.namprd18.prod.outlook.com (2603:10b6:610:e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 10:24:53 +0000
Received: from BY3PR18MB4612.namprd18.prod.outlook.com
 ([fe80::7050:fdf4:a7f2:18ed]) by BY3PR18MB4612.namprd18.prod.outlook.com
 ([fe80::7050:fdf4:a7f2:18ed%6]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 10:24:53 +0000
From: Manish Chopra <manishc@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Ariel Elior
	<aelior@marvell.com>, Alok Prasad <palok@marvell.com>,
        Nilesh Javali
	<njavali@marvell.com>,
        Saurav Kashyap <skashyap@marvell.com>,
        "jmeneghi@redhat.com" <jmeneghi@redhat.com>,
        "yuval.mintz@qlogic.com"
	<yuval.mintz@qlogic.com>,
        Sudarsana Reddy Kalluru <skalluru@marvell.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "horms@kernel.org" <horms@kernel.org>,
        David Miller
	<davem@davemloft.net>
Subject: RE: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend and
 resume
Thread-Topic: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend
 and resume
Thread-Index: AQHZy+1lZM+1lomQPk24GXtBdk57Ya/kzXtAgADU2oCAA/gYQA==
Date: Mon, 14 Aug 2023 10:24:52 +0000
Message-ID: 
 <BY3PR18MB46128F47E175B8CFDECE3077AB17A@BY3PR18MB4612.namprd18.prod.outlook.com>
References: <20230809134339.698074-1-manishc@marvell.com>
	<20230810174718.38190258@kernel.org>
	<BY3PR18MB4612F2621E50B2F12F2BC342AB10A@BY3PR18MB4612.namprd18.prod.outlook.com>
 <20230811144507.5ab3fdae@kernel.org>
In-Reply-To: <20230811144507.5ab3fdae@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWFuaXNoY1xh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWNiOTAyOGY5LTNhOGMtMTFlZS1iNmRmLWQ4Zjg4?=
 =?us-ascii?Q?MzVmNjc2YVxhbWUtdGVzdFxjYjkwMjhmYi0zYThjLTExZWUtYjZkZi1kOGY4?=
 =?us-ascii?Q?ODM1ZjY3NmFib2R5LnR4dCIgc3o9IjE0MjciIHQ9IjEzMzM2NDgyMjg5MDQz?=
 =?us-ascii?Q?NDg4MSIgaD0idmhDTUNLeHdOdXM3OXJWZ01Na1UydDFqMzlvPSIgaWQ9IiIg?=
 =?us-ascii?Q?Ymw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTkNnVUFBTjRQQUFC?=
 =?us-ascii?Q?QjBlcU5tYzdaQWFKQ0lQNEpsTWpzb2tJZy9nbVV5T3daQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUhBQUFBQnVEd0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQVFFQkFBQUFJN3FUcEFDQUFRQUFBQUFBQUFBQUFKNEFBQUJoQUdRQVpB?=
 =?us-ascii?Q?QnlBR1VBY3dCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY0FC?=
 =?us-ascii?Q?bEFISUFjd0J2QUc0QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWXdCMUFITUFkQUJ2QUcwQVh3QndBR2dBYndCdUFHVUFiZ0Ix?=
 =?us-ascii?Q?QUcwQVlnQmxBSElBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVB?=
 =?us-ascii?Q?Y3dCMEFHOEFiUUJmQUhNQWN3QnVBRjhBWkFCaEFITUFhQUJmQUhZQU1BQXlB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdN?=
 =?us-ascii?Q?QWRRQnpBSFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0Jr?=
 =?us-ascii?Q?QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZd0IxQUhNQWRBQnZBRzBB?=
 =?us-ascii?Q?WHdCekFITUFiZ0JmQUc0QWJ3QmtBR1VBYkFCcEFHMEFhUUIwQUdVQWNnQmZB?=
 =?us-ascii?Q?SFlBTUFBeUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFB?=
 =?us-ascii?Q?QUFJQUFBQUFBSjRBQUFCakFIVUFjd0IwQUc4QWJRQmZBSE1BY3dCdUFGOEFj?=
 =?us-ascii?Q?d0J3QUdFQVl3QmxBRjhBZGdBd0FESUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFjd0JyQUhrQWNBQmxBRjhBWXdCb0FHRUFkQUJmQUcwQVpR?=
 =?us-ascii?Q?QnpBSE1BWVFCbkFHVUFYd0IyQURBQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVpBQnNBSEFBWHdCekFH?=
 =?us-ascii?Q?d0FZUUJqQUdzQVh3QmpBR2dBWVFCMEFGOEFiUUJsQUhNQWN3QmhBR2NBWlFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJrQUd3QWNBQmZB?=
 =?us-ascii?Q?SFFBWlFCaEFHMEFjd0JmQUc4QWJnQmxBR1FBY2dCcEFIWUFaUUJmQUdZQWFR?=
 =?us-ascii?Q?QnNBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFB?=
 =?us-ascii?Q?QUFBQUFBQUFnQUFBQUFBbmdBQUFHVUFiUUJoQUdrQWJBQmZBR0VBWkFCa0FI?=
 =?us-ascii?Q?SUFaUUJ6QUhNQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFEZ0FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFB?=
 =?us-ascii?Q?Q2VBQUFBYlFCaEFISUFkZ0JsQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QmhBR3dBYndCdUFHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dC?=
 =?us-ascii?Q?MkFHVUFiQUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0J1QUdFQWJRQmxBSE1B?=
 =?us-ascii?Q?WHdCeUFHVUFjd0IwQUhJQWFRQmpBSFFBWlFCa0FGOEFZUUJzQUc4QWJnQmxB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FGOEFjQUJ5?=
 =?us-ascii?Q?QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBSElBWlFCekFIUUFj?=
 =?us-ascii?Q?Z0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4QVpBQmxBSE1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHRUFjZ0J0QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refthree: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJ?=
 =?us-ascii?Q?QUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBWndCdkFHOEFad0Jz?=
 =?us-ascii?Q?QUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBRzBB?=
 =?us-ascii?Q?WVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QVl3QnZB?=
 =?us-ascii?Q?R1FBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0Fi?=
 =?us-ascii?Q?QUJmQUhBQWNnQnZBR29BWlFCakFIUUFYd0JqQUc4QVpBQmxBSE1BWHdCa0FH?=
 =?us-ascii?Q?a0FZd0IwQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFB?=
 =?us-ascii?Q?QUlBQUFBQUFKNEFBQUJ0QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFn?=
 =?us-ascii?Q?QmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3QmZBR01BYndCdUFHWUFhUUJrQUdV?=
 =?us-ascii?Q?QWJnQjBBR2tBWVFCc0FGOEFiUUJoQUhJQWRnQmxBR3dBYkFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFH?=
 =?us-ascii?Q?MEFZUUJ5QUhZQVpRQnNBR3dBWHdCd0FISUFid0JxQUdVQVl3QjBBRjhBYmdC?=
 =?us-ascii?Q?aEFHMEFaUUJ6QUY4QVl3QnZBRzRBWmdCcEFHUUFaUUJ1QUhRQWFRQmhBR3dB?=
 =?us-ascii?Q?WHdCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBYndCeUFGOEFZUUJ5QUcwQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: 
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VB?=
 =?us-ascii?Q?QUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhRQVh3?=
 =?us-ascii?Q?QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJwQUdF?=
 =?us-ascii?Q?QWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCbkFHOEFid0Ju?=
 =?us-ascii?Q?QUd3QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFH?=
 =?us-ascii?Q?VUFiQUJzQUY4QWNBQnlBRzhBYWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dC?=
 =?us-ascii?Q?ZkFISUFaUUJ6QUhRQWNnQnBBR01BZEFCbEFHUUFYd0J0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFB?=
 =?us-ascii?Q?QUFBQUFBQWdBQUFBQUFuZ0FBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJ?=
 =?us-ascii?Q?QWJ3QnFBR1VBWXdCMEFGOEFiZ0JoQUcwQVpRQnpBRjhBY2dCbEFITUFkQUJ5?=
 =?us-ascii?Q?QUdrQVl3QjBBR1VBWkFCZkFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdCdkFISUFY?=
 =?us-ascii?Q?d0JoQUhJQWJRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFD?=
 =?us-ascii?Q?ZUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIUUFaUUJ5QUcwQWFRQnVBSFVB?=
 =?us-ascii?Q?Y3dBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBRjhBZHdCdkFISUFaQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4612:EE_|CH0PR18MB4163:EE_
x-ms-office365-filtering-correlation-id: 862bc985-ade1-41fa-7fc7-08db9cb0b2bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EcxFffECQsWfgOl9pu6kqNEpEmqNzT6YP3BYtFJ1Swl6trqpsEI92JctKpONDvw0iIAQSv7Kp3i0lx3dWGgh3IA1ZdVGAOt/cQR5D/ed996F5L7vtlTecSnmXwB1qDsKA6Sf0G4EBvMye/rGJMCkz4rxTYkWAROLwBuT/DfRlMclZS1Op5J4S+dGFKvdZ/GvXmD98ukPcvS+zTc0HKmhlxdjwX/QzXTv3WDgvDhMmrDqtDvvnXvgFQHrwR8zwkEug8nKRwN1R03PxuWsOjO8wMPNXG79dUP1bZUZlfv83eBEhUIdVWI8O0tI+7xzflMS64wLjE2f8QvlSdeK9vXttY1GBTmtsJokh3sBXhQnByrw84GCXxx8ZhOXUCw2LV+jIpCeTV8+oXY5yhSDyREo4oqEJbPFJ3QDVBmedUOw1M/J5E3dPDBh8trToUtunBdmbilnHtujsyCIFNuuw389GtTtUX87yQOyILNqA+Ty0rKNUAViFiqm/iU47hGAstdse4MWROIjQKsVeS3ESKLtWZLQsTRE5QasYm0TYtIxJSVzXyuHHnIMKxxStu9CyrQYHZVYehdXjAh6IHCaMR5aPwDHl11lmFV2oXQfu36Dk9XZ87KUU6yVeQ0CfsdEdo8M
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4612.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(136003)(396003)(366004)(376002)(1800799006)(186006)(451199021)(6506007)(53546011)(26005)(8936002)(41300700001)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(8676002)(316002)(9686003)(83380400001)(71200400001)(7696005)(122000001)(478600001)(38100700002)(55016003)(54906003)(15650500001)(33656002)(86362001)(6916009)(4326008)(5660300002)(2906002)(38070700005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?JcsbnGZeHvOCiU4RIx7IgicD0G/WGVyoY27BitHSHossCa655ibUUxkb/YS5?=
 =?us-ascii?Q?BdHBCWH5gdJ6RPP6vQ0a0SdQCGHk0r0eMQs/h5NPrY1XZYdEOi3DKqpQ/yL6?=
 =?us-ascii?Q?3u5HkxfN//adUfjJyTO95AfOzHoTkWP9zD8RIvWr5pgYYaSdF0/SogLCmgM/?=
 =?us-ascii?Q?UkIZ/qdlBBMLe10bjXkG5MRvOFEuBMTKmgezTC2yJcAZoZUiGaRlf6k3Euk9?=
 =?us-ascii?Q?L/0rNrJuZcoKA6zcCjUyEKD2VGNAL5IrSE5pd5tG/puuh9Owe19X03wWkPxd?=
 =?us-ascii?Q?3cS21ezDpRupTc/THSXX6LnXsS2ZtSfoyLvb1pn4do6wK1kl2vLrd3Pr/qGn?=
 =?us-ascii?Q?vspzg64CFWC89jfr+wjwsQidi/isjfxrLPuqURLh39gXlyA+9EtZV/Ku6cyu?=
 =?us-ascii?Q?J6K/ZDhv23kUDyZJhxgV+8pTloAQ/cDeAurYlMxuidS6gzAIKneyzrrMDfcq?=
 =?us-ascii?Q?F75XTwPhJyNE9lygRUKsCZ1XpgnyUoFxm7EtxlFYpGSLFUfJfhn4V3S8cFCm?=
 =?us-ascii?Q?SZdy7GF2bmL/yyDkkL5eyQa2mEW5RkixxrONw5EL+WaLzlxBhmF17KlPRzSl?=
 =?us-ascii?Q?lq8vd2a4kNBR5afJdxOsNvTCJvjNAwhlIt0gGea5gPl3UBOBEN1xOoJWrwvE?=
 =?us-ascii?Q?/nYDgqXSJGIcbEI37++9MGp2px6yiLf/kg2vwH8nvinsw8hxcxvyw/auaN5q?=
 =?us-ascii?Q?eW441NfWt3Q3OTMQdQ92n9wXWZeKD7fVygD5RydM5772vMrVBka7+0ued6I2?=
 =?us-ascii?Q?NHW1Vm6udqG8VrA9APVCEuHqJg4eRKB6ZqS6ERRNfLozCBodTK4kZZ24E+Cy?=
 =?us-ascii?Q?5+51GgFhU9Shp1YBhwalrTURinMGTFq1WHH2gi+rf4TBGDu1EooCBiHJQBc4?=
 =?us-ascii?Q?rjiLUlCUL+6sGWDaR+a5IEMmdADY6kQQX5leYIoBf5BEeO0mrJBGOY17N6xJ?=
 =?us-ascii?Q?gkMotoSypo728k2LVt0KfincDDk1W7gpnyzJzrj1ZcJx4FaQRylV4mruimzl?=
 =?us-ascii?Q?PPIEtAGsl+AcS5dII+kt2ZoQe+MgccjvnEY4GwWHJYVATM7u8Zi3dmvA4b4T?=
 =?us-ascii?Q?Y3rYJPbyvx1yO5587VRQAjBtOnWCeD5tHdQULPJY77seyJthRGGzDRMl7mVX?=
 =?us-ascii?Q?sTVa+qoj4h+RWsIc3YwvbeX7nqe9P/UwagcUJbNDuOFaVvigSReWE0/8+riN?=
 =?us-ascii?Q?qYpUa8rhqiQkEl3S96dC5hxjffuirKXYmhbuB4VmmDfICj2VhbfolwHapIx8?=
 =?us-ascii?Q?SFE2O+KvGD1+SChfmbEGzXvtDCQWvl6zza4wMN3Cj9o5v3Q+YAmS1eVqxAF7?=
 =?us-ascii?Q?8ef5e4S7beKLIsiFN6cn6+pKUlCFVmijGHiJWb9ACEOGLFp8pi4NW5eJcQHt?=
 =?us-ascii?Q?qsGTo6RES6ZdkopzlQR9sxof7cn5W14G75d+Kpy5kyyQ8MjUq0HM4ZmELFNp?=
 =?us-ascii?Q?pCUA+WoOTYMy1HExSxs64Y70Nd7lGjIDeZiTPd3IoJ5GHM6QhTClXt1atwOT?=
 =?us-ascii?Q?nTAnB+lCordpkXFR99YsKFC90c4geQe4yF9mHe1dkFZ489wx5VT42Lpzhf9n?=
 =?us-ascii?Q?lslMj2SLa2Ec/cUsscU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4612.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 862bc985-ade1-41fa-7fc7-08db9cb0b2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 10:24:52.9690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R5VHsngXaqZDEuYT14lnM0SNjRNLHyNnEycag8vGzF9o4tp60vFNwsy3EJKmUGcxtcY1hiNEEuzj/qHWTNWu0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR18MB4163
X-Proofpoint-GUID: FuhSUc3jPN2V7eNAb7pD_jR74IWlGrub
X-Proofpoint-ORIG-GUID: FuhSUc3jPN2V7eNAb7pD_jR74IWlGrub
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_06,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, August 12, 2023 3:15 AM
> To: Manish Chopra <manishc@marvell.com>
> Cc: netdev@vger.kernel.org; Ariel Elior <aelior@marvell.com>; Alok Prasad
> <palok@marvell.com>; Nilesh Javali <njavali@marvell.com>; Saurav Kashyap
> <skashyap@marvell.com>; jmeneghi@redhat.com; yuval.mintz@qlogic.com;
> Sudarsana Reddy Kalluru <skalluru@marvell.com>; pabeni@redhat.com;
> edumazet@google.com; horms@kernel.org; David Miller
> <davem@davemloft.net>
> Subject: Re: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspen=
d and
> resume
>=20
> On Fri, 11 Aug 2023 09:31:15 +0000 Manish Chopra wrote:
> > > Does the FW end up recovering? That could still be preferable to
> > > rejecting suspend altogether. Reject is a big hammer, I'm a bit
> > > worried it will cause a regression in stable.
> >
> > Yes, By adding the driver's suspend handler with explicit error
> > returned to PCI subsystem prevents the system wide suspend and does
> > not impact the device/FW at all. It keeps them operational as they were
> before.
>=20
> I'm asking about recovery without this patch, not with it.
> That should be evident from the text I'm replying under.

Nope, It does not recover. We have to power cycle the system to recover.

